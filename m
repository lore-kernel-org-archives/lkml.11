Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9920EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 13:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346764AbiFTNfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 09:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346350AbiFTNcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:32:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2509B2613F;
        Mon, 20 Jun 2022 06:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B04EB811DA;
        Mon, 20 Jun 2022 13:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F41C3411B;
        Mon, 20 Jun 2022 13:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655730418;
        bh=PkqkrDz7EiznkeuOMswvSLdRA7mpt5+yw/0olC7jZys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wdzty7E9sfmRMDs28IIvHnqCqk16qnm6oyMLabEQtu4HPhox0B2VVvCKlfkoTZS4e
         6X1ms/SnZObXBAlzuUGtAi+8wGqYIuTBly9T1tsE+5joExJy2xv45C34etdKfA5MBL
         rMuYzQpu0I8uPgta1gIVWY5ImZr+1lumNtyU2Mr4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 047/106] pNFS: Dont keep retrying if the server replied NFS4ERR_LAYOUTUNAVAILABLE
Date:   Mon, 20 Jun 2022 14:51:06 +0200
Message-Id: <20220620124725.781072299@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620124724.380838401@linuxfoundation.org>
References: <20220620124724.380838401@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit fe44fb23d6ccde4c914c44ef74ab8d9d9ba02bea ]

If the server tells us that a pNFS layout is not available for a
specific file, then we should not keep pounding it with further
layoutget requests.

Fixes: 183d9e7b112a ("pnfs: rework LAYOUTGET retry handling")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/pnfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 1b4dd8b828de..9b2549222391 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2152,6 +2152,12 @@ pnfs_update_layout(struct inode *ino,
 		case -ERECALLCONFLICT:
 		case -EAGAIN:
 			break;
+		case -ENODATA:
+			/* The server returned NFS4ERR_LAYOUTUNAVAILABLE */
+			pnfs_layout_set_fail_bit(
+				lo, pnfs_iomode_to_fail_bit(iomode));
+			lseg = NULL;
+			goto out_put_layout_hdr;
 		default:
 			if (!nfs_error_is_fatal(PTR_ERR(lseg))) {
 				pnfs_layout_clear_fail_bit(lo, pnfs_iomode_to_fail_bit(iomode));
-- 
2.35.1



