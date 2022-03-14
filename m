Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F75C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 12:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241311AbiCNMYs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 08:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241729AbiCNMSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:18:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CFABC0A;
        Mon, 14 Mar 2022 05:12:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11B8061382;
        Mon, 14 Mar 2022 12:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03C0C340E9;
        Mon, 14 Mar 2022 12:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647259973;
        bh=jt+cYboBf6a9eltsE2cy5RocCv4dZOC0FFIQxWaw7dY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qvUTwMRbkcq0fd2ZUNslUtrZEXKMw96l9txMNh4WPKddUbg5al+QMvXcbOAZgb51H
         BYktA9jfwO6lo9167JmRHuve0WRDYKKpC28ajXS3BGhlwUwwqlYuFKcWLhlgTeiwRA
         A5pi2zKM+bv3EH9AYpj08T4+76XpTMe1s8jHH7/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Skripkin <paskripkin@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        syzbot+35eebd505e97d315d01c@syzkaller.appspotmail.com
Subject: [PATCH 5.16 004/121] HID: hid-thrustmaster: fix OOB read in thrustmaster_interrupts
Date:   Mon, 14 Mar 2022 12:53:07 +0100
Message-Id: <20220314112744.246863886@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314112744.120491875@linuxfoundation.org>
References: <20220314112744.120491875@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

[ Upstream commit fc3ef2e3297b3c0e2006b5d7b3d66965e3392036 ]

Syzbot reported an slab-out-of-bounds Read in thrustmaster_probe() bug.
The root case is in missing validation check of actual number of endpoints.

Code should not blindly access usb_host_interface::endpoint array, since
it may contain less endpoints than code expects.

Fix it by adding missing validaion check and print an error if
number of endpoints do not match expected number

Fixes: c49c33637802 ("HID: support for initialization of some Thrustmaster wheels")
Reported-and-tested-by: syzbot+35eebd505e97d315d01c@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-thrustmaster.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-thrustmaster.c b/drivers/hid/hid-thrustmaster.c
index 03b935ff02d5..9da4240530dd 100644
--- a/drivers/hid/hid-thrustmaster.c
+++ b/drivers/hid/hid-thrustmaster.c
@@ -158,6 +158,12 @@ static void thrustmaster_interrupts(struct hid_device *hdev)
 		return;
 	}
 
+	if (usbif->cur_altsetting->desc.bNumEndpoints < 2) {
+		kfree(send_buf);
+		hid_err(hdev, "Wrong number of endpoints?\n");
+		return;
+	}
+
 	ep = &usbif->cur_altsetting->endpoint[1];
 	b_ep = ep->desc.bEndpointAddress;
 
-- 
2.34.1



