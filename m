Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064D7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245520AbiBUJHQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:07:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347190AbiBUJA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:00:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BD727B27;
        Mon, 21 Feb 2022 00:56:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 365EEB80EAA;
        Mon, 21 Feb 2022 08:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1F1C340E9;
        Mon, 21 Feb 2022 08:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645433727;
        bh=hevMNI8JP0s+vSotsMBfQsYPHAGrUmm4+XL55KLcPJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vw94g88A4eV0nUmEadY16bOKwO375nYVsv2IbR/CnZ6G/T7ztgcmhzYo9UdEDVtx7
         wtUwZ77HMrlXDQq4ldyQL0HzMDFb8lkH7FdXeKAFmU6EbNLXpxcrgmKSJL8eiz9zuS
         nXZwTRKDAhxP92Q3Si4s7QJ0dfJ5bRv1HDt1dQuo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 06/58] btrfs: send: in case of IO error log it
Date:   Mon, 21 Feb 2022 09:48:59 +0100
Message-Id: <20220221084912.092328977@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084911.895146879@linuxfoundation.org>
References: <20220221084911.895146879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dāvis Mosāns <davispuh@gmail.com>

commit 2e7be9db125a0bf940c5d65eb5c40d8700f738b5 upstream.

Currently if we get IO error while doing send then we abort without
logging information about which file caused issue.  So log it to help
with debugging.

CC: stable@vger.kernel.org # 4.9+
Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/send.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4956,6 +4956,10 @@ static ssize_t fill_read_buf(struct send
 			lock_page(page);
 			if (!PageUptodate(page)) {
 				unlock_page(page);
+				btrfs_err(fs_info,
+			"send: IO error at offset %llu for inode %llu root %llu",
+					page_offset(page), sctx->cur_ino,
+					sctx->send_root->root_key.objectid);
 				put_page(page);
 				ret = -EIO;
 				break;


