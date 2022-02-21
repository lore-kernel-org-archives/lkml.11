Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D62C4707F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353068AbiBUJsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:48:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351162AbiBUJmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:42:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99AB3DDE8;
        Mon, 21 Feb 2022 01:17:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0E96CCE0E80;
        Mon, 21 Feb 2022 09:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE87BC340E9;
        Mon, 21 Feb 2022 09:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645435058;
        bh=GNWDnUQSkQoHDG7N0AaNCU2cKUgmvzCueWCbAOZmT/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SnjNIc2J7IcEKf8uVLCyrH/1XslWo8xJdf1c2Lc1b8N0+Ly39eyq+DbX+B4/zKys2
         zDOcWPTeIY8kfC2a1SUIAEGTCFXhmDiT18E3aVoFdAo4GeiF0Rwt4/BbNuAb3KLfHt
         TwwuCx+cVOWtyxzmrQvn1VapRBTGqPIxfpxRbZkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.16 029/227] btrfs: send: in case of IO error log it
Date:   Mon, 21 Feb 2022 09:47:28 +0100
Message-Id: <20220221084935.809388288@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084934.836145070@linuxfoundation.org>
References: <20220221084934.836145070@linuxfoundation.org>
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
@@ -4983,6 +4983,10 @@ static int put_file_data(struct send_ctx
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


