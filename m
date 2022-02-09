Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41DCC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 06:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiBIGIR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 01:08:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbiBIGBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:01:55 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25937C05CB91;
        Tue,  8 Feb 2022 22:01:58 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V3zwJoJ_1644386496;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V3zwJoJ_1644386496)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 14:01:37 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/22] erofs: implement fscache-based data readahead for inline layout
Date:   Wed,  9 Feb 2022 14:01:07 +0800
Message-Id: <20220209060108.43051-22-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index ef5eef33e3d5..003f9abdaf1b 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -198,6 +198,7 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
 enum erofs_fscache_readahead_type {
 	EROFS_FSCACHE_READAHEAD_TYPE_HOLE,
 	EROFS_FSCACHE_READAHEAD_TYPE_NOINLINE,
+	EROFS_FSCACHE_READAHEAD_TYPE_INLINE,
 };
 
 static int erofs_fscache_do_readahead(struct readahead_control *rac,
@@ -231,6 +232,9 @@ static int erofs_fscache_do_readahead(struct readahead_control *rac,
 			ret = erofs_fscache_readpage_noinline(page, fsmap);
 			fsmap->m_pa += EROFS_BLKSIZ;
 			break;
+		case EROFS_FSCACHE_READAHEAD_TYPE_INLINE:
+			ret = erofs_fscache_readpage_inline(page, fsmap);
+			break;
 		default:
 			DBG_BUGON(1);
 			return -EINVAL;
@@ -285,6 +289,10 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
 				ret = erofs_fscache_do_readahead(rac, &fsmap,
 					EROFS_FSCACHE_READAHEAD_TYPE_NOINLINE);
 				break;
+			case EROFS_INODE_FLAT_INLINE:
+				ret = erofs_fscache_do_readahead(rac, &fsmap,
+					EROFS_FSCACHE_READAHEAD_TYPE_INLINE);
+				break;
 			default:
 				DBG_BUGON(1);
 				return;
-- 
2.27.0

