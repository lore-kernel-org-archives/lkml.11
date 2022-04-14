Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26D2C3527C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243826AbiDNOhH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245262AbiDNNiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:38:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBFF9F3A5;
        Thu, 14 Apr 2022 06:31:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A19DE61BA6;
        Thu, 14 Apr 2022 13:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD58DC385A1;
        Thu, 14 Apr 2022 13:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649943107;
        bh=UxiJWQzOxUTKSG/tgEQ7ATLQBu5U6+KUi7zIDsnJIkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PmWX782I7jmUlzjoPlkxwTi1Dt3m1v6c6g13Y2Xc7cREvHHUdPUrYErUMfBHJ7QpL
         p19KcncRYgZR7mr7BIY+C364Au1dyLNP7NOlEsEl5278GCOqQ7Oa6qIZP6r+RWgykI
         G3o16KZE+U9mXi0sL+1YcLJdP+Ma4urRCQYuOPGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.4 036/475] NFSD: prevent underflow in nfssvc_decode_writeargs()
Date:   Thu, 14 Apr 2022 15:07:01 +0200
Message-Id: <20220414110856.167378742@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110855.141582785@linuxfoundation.org>
References: <20220414110855.141582785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 184416d4b98509fb4c3d8fc3d6dc1437896cc159 upstream.

Smatch complains:

	fs/nfsd/nfsxdr.c:341 nfssvc_decode_writeargs()
	warn: no lower bound on 'args->len'

Change the type to unsigned to prevent this issue.

Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfsproc.c |    2 +-
 fs/nfsd/xdr.h     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -230,7 +230,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 	unsigned long cnt = argp->len;
 	unsigned int nvecs;
 
-	dprintk("nfsd: WRITE    %s %d bytes at %d\n",
+	dprintk("nfsd: WRITE    %s %u bytes at %d\n",
 		SVCFH_fmt(&argp->fh),
 		argp->len, argp->offset);
 
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -33,7 +33,7 @@ struct nfsd_readargs {
 struct nfsd_writeargs {
 	svc_fh			fh;
 	__u32			offset;
-	int			len;
+	__u32			len;
 	struct kvec		first;
 };
 


