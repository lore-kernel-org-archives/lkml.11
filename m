Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88686C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 01:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1843895AbiDFBmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 21:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354717AbiDEKPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:15:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D0D6C489;
        Tue,  5 Apr 2022 03:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FC1FB81C83;
        Tue,  5 Apr 2022 10:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706B3C385A2;
        Tue,  5 Apr 2022 10:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649152946;
        bh=i2lYnXvB9uh7beCesqpoNaBCXU6jLSBPvK+0DaTe7dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vvv1cTdqG9HW99q5+q7gEG2wMBuZ/M5AUsad5VjMv18pP6F93IyoFH5M3LjZKXi2c
         S19C3X2iyP8NbrXp7qumd/eBOXH1TnwUacpjoE8TJzz+YqRXyKj3jrQHvcDfZ9tSgw
         cu6jQJROQLe/7w8Dbuh8lob1CKQQW8AdwAXFlmo0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.10 047/599] NFSD: prevent integer overflow on 32 bit systems
Date:   Tue,  5 Apr 2022 09:25:41 +0200
Message-Id: <20220405070300.228545542@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 23a9dbbe0faf124fc4c139615633b9d12a3a89ef upstream.

On a 32 bit system, the "len * sizeof(*p)" operation can have an
integer overflow.

Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/sunrpc/xdr.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -603,6 +603,8 @@ xdr_stream_decode_uint32_array(struct xd
 
 	if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
 		return -EBADMSG;
+	if (len > SIZE_MAX / sizeof(*p))
+		return -EBADMSG;
 	p = xdr_inline_decode(xdr, len * sizeof(*p));
 	if (unlikely(!p))
 		return -EBADMSG;


