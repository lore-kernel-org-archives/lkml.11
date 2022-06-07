Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA75CCA481
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 20:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358847AbiFGUSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 16:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356804AbiFGT2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 15:28:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFEF1A1954;
        Tue,  7 Jun 2022 11:10:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CAFB617B3;
        Tue,  7 Jun 2022 18:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD3CC385A2;
        Tue,  7 Jun 2022 18:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654625449;
        bh=sXhJAaUuI/+gq3WeDf4mmfghVWZcp4jTAcy/lc5Txhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+DJ5vGYRFgwVNZ9HeK8+N6Kz3yG6OHLIhc9XJttFjxa2CcyCrDlBqDJGvCuY/+//
         ZiuUK5b/bbbWiPMs4mndpp0SscGAVlk7qI/79UWzFyCp2/hhY9C0184LHTCfejlyS2
         lpq5eCWE5I1U181pzb1x2CvyjM4+3+1nsnq+MZFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kari Argillander <kari.argillander@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 5.17 023/772] fs/ntfs3: Check new size for limits
Date:   Tue,  7 Jun 2022 18:53:35 +0200
Message-Id: <20220607164949.697143067@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607164948.980838585@linuxfoundation.org>
References: <20220607164948.980838585@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

commit 114346978cf61de02832cc3cc68432a3de70fb38 upstream.

We must check size before trying to allocate.
Size can be set for example by "ulimit -f".
Fixes xfstest generic/228
Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ntfs3/file.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -662,7 +662,13 @@ static long ntfs_fallocate(struct file *
 		/*
 		 * Normal file: Allocate clusters, do not change 'valid' size.
 		 */
-		err = ntfs_set_size(inode, max(end, i_size));
+		loff_t new_size = max(end, i_size);
+
+		err = inode_newsize_ok(inode, new_size);
+		if (err)
+			goto out;
+
+		err = ntfs_set_size(inode, new_size);
 		if (err)
 			goto out;
 


