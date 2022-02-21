Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A208C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 08:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345204AbiBUIw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 03:52:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345487AbiBUIw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:52:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C65E23;
        Mon, 21 Feb 2022 00:52:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98E7BB80E9E;
        Mon, 21 Feb 2022 08:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6A8C340E9;
        Mon, 21 Feb 2022 08:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645433519;
        bh=Ha5FXiN5IM6Ijp+HmsPrFdAwbwKjQeirEg0DSequ2Zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k0esbSUgTSOIYMZx4fDWjENlSW1Vyb5VI5OXo7aje0FnGNoFn9eCoIJ4c0WJ9Cs15
         o/KVG1nP5ettTeWvJG6pxnuYAT0nUJXeAc8vJ6dwZnmWOmDyjMbT3rQMaE6R0wYglV
         g12IMe1cqaBMcBSbTt+KiTAWAFDNFUCNiQHWsENA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.9 06/33] btrfs: send: in case of IO error log it
Date:   Mon, 21 Feb 2022 09:48:59 +0100
Message-Id: <20220221084908.769515115@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084908.568970525@linuxfoundation.org>
References: <20220221084908.568970525@linuxfoundation.org>
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
@@ -4675,6 +4675,10 @@ static ssize_t fill_read_buf(struct send
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


