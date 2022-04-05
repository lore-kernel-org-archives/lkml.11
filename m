Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E90C43217
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 11:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377602AbiDEL3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243827AbiDEIvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:51:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7499CA0F2;
        Tue,  5 Apr 2022 01:39:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FD73B81C14;
        Tue,  5 Apr 2022 08:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20CAC385A0;
        Tue,  5 Apr 2022 08:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147914;
        bh=+3MwjoxU6y9Rz147dPjjPlPFEMsY7UQgaL93494ZQ1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sc+KngHyGO2EPNP5t/dIxiNuW3Fjz17zSI62EKm90AdI+Jq7bBcvOvRaev3FSeYFi
         6AMbsPTmCwYoL+NNsC/f74a5XMj69Q04I8r1P5ylDhHKXDSeUpCUaOLp4iNNK5kfn8
         D8LD8YaZowcsZyiLK+ponaUs768Yb3r6Raw51MDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tadeusz Struk <tadeusz.struk@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.16 0168/1017] crypto: rsa-pkcs1pad - fix buffer overread in pkcs1pad_verify_complete()
Date:   Tue,  5 Apr 2022 09:18:01 +0200
Message-Id: <20220405070359.211588145@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit a24611ea356c7f3f0ec926da11b9482ac1f414fd upstream.

Before checking whether the expected digest_info is present, we need to
check that there are enough bytes remaining.

Fixes: a49de377e051 ("crypto: Add hash param to pkcs1pad")
Cc: <stable@vger.kernel.org> # v4.6+
Cc: Tadeusz Struk <tadeusz.struk@linaro.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/rsa-pkcs1pad.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/crypto/rsa-pkcs1pad.c
+++ b/crypto/rsa-pkcs1pad.c
@@ -476,6 +476,8 @@ static int pkcs1pad_verify_complete(stru
 	pos++;
 
 	if (digest_info) {
+		if (digest_info->size > dst_len - pos)
+			goto done;
 		if (crypto_memneq(out_buf + pos, digest_info->data,
 				  digest_info->size))
 			goto done;


