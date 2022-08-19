Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B55C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 16:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354067AbiHSQv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354044AbiHSQuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 12:50:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F21CD44;
        Fri, 19 Aug 2022 09:13:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0CF0618BB;
        Fri, 19 Aug 2022 16:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA62BC433D7;
        Fri, 19 Aug 2022 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660925547;
        bh=ckohcA+yLadJmCHut3jj5GmAulVKJf3WkhvytL8MJkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tkbtsv97Elp5LRd5gjNBQLayVrrFgEhmASk4a1fYgpTSgrfhEpqRaCM8UYQyD+PtR
         UgGXzVPZI1lGDlNj1Ym7Sy2xDkQzJNOxoXTjJ62qW1DM1CScuUuzu5v5qLSO3AVQNC
         sd//j498jH8PFfGvh2gaWUDOPzluaOY7Ch8gusVo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 5.10 525/545] dm raid: fix address sanitizer warning in raid_resume
Date:   Fri, 19 Aug 2022 17:44:55 +0200
Message-Id: <20220819153853.049218454@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819153829.135562864@linuxfoundation.org>
References: <20220819153829.135562864@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 7dad24db59d2d2803576f2e3645728866a056dab upstream.

There is a KASAN warning in raid_resume when running the lvm test
lvconvert-raid.sh. The reason for the warning is that mddev->raid_disks
is greater than rs->raid_disks, so the loop touches one entry beyond
the allocated length.

Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-raid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3794,7 +3794,7 @@ static void attempt_restore_of_faulty_de
 
 	memset(cleared_failed_devices, 0, sizeof(cleared_failed_devices));
 
-	for (i = 0; i < mddev->raid_disks; i++) {
+	for (i = 0; i < rs->raid_disks; i++) {
 		r = &rs->dev[i].rdev;
 		/* HM FIXME: enhance journal device recovery processing */
 		if (test_bit(Journal, &r->flags))


