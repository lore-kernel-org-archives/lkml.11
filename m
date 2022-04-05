Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D892FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 14:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387003AbiDEO2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 10:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbiDEJdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:33:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E075656B;
        Tue,  5 Apr 2022 02:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC18361574;
        Tue,  5 Apr 2022 09:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87FBC385A2;
        Tue,  5 Apr 2022 09:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649150468;
        bh=YZdqkHxdou06xEwB5O8wkX6sBT8EGjd1hPU579OKop8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z7ByhxvO57KrmiqMxSn+6JjcxJkX1RbGD8xDLq3fGln+aR4n/yQ95TdE9seqGrXSq
         sI67NYbUn3RVwmtqGn6u9KidGHHLQMuWGCYDSB2+0cQ0DOGO5vbkbMTfO5xFhYYidN
         N/PNjzdtS/Jot8t8Q0h3LszJ4vpn5QKlTFdMWs20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 066/913] NFSD: prevent integer overflow on 32 bit systems
Date:   Tue,  5 Apr 2022 09:18:48 +0200
Message-Id: <20220405070341.801304195@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
References: <20220405070339.801210740@linuxfoundation.org>
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
@@ -731,6 +731,8 @@ xdr_stream_decode_uint32_array(struct xd
 
 	if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
 		return -EBADMSG;
+	if (len > SIZE_MAX / sizeof(*p))
+		return -EBADMSG;
 	p = xdr_inline_decode(xdr, len * sizeof(*p));
 	if (unlikely(!p))
 		return -EBADMSG;


