Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8905FC3814E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 10:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352577AbiHWKFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352203AbiHWKBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:01:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7CB4055C;
        Tue, 23 Aug 2022 01:48:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCDA36122F;
        Tue, 23 Aug 2022 08:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A359AC433C1;
        Tue, 23 Aug 2022 08:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661244537;
        bh=2MjMmv1DWYOrh+U1u+hL4AFpZ83wNRy9AWvFn4o+AHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mlAFuY89bxNTqXGTRJKnQpfw4yfqaWWZxEBKkYnkSmhj5YJ35x//13m5fumxcMF2O
         riM9QDkNUZ+Hhfg3nxiIytqAHUVyyzh+TMbKiY0Opuvlp0AQPgv9IxF+cUpKmRJoOm
         Paiuf3Q1KvRHNn1cf4wo3UgLGhm3EIxlhZ4PxjU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liangbin Lian <jjm2473@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 5.15 108/244] fs/ntfs3: Fix missing i_op in ntfs_read_mft
Date:   Tue, 23 Aug 2022 10:24:27 +0200
Message-Id: <20220823080102.621190771@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080059.091088642@linuxfoundation.org>
References: <20220823080059.091088642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

commit 37a530bfe56ca9a0d3129598803f2794c7428aae upstream.

There is null pointer dereference because i_op == NULL.
The bug happens because we don't initialize i_op for records in $Extend.
Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")

Reported-by: Liangbin Lian <jjm2473@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ntfs3/inode.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -430,6 +430,7 @@ end_enum:
 	} else if (fname && fname->home.low == cpu_to_le32(MFT_REC_EXTEND) &&
 		   fname->home.seq == cpu_to_le16(MFT_REC_EXTEND)) {
 		/* Records in $Extend are not a files or general directories. */
+		inode->i_op = &ntfs_file_inode_operations;
 	} else {
 		err = -EINVAL;
 		goto out;


