Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0E5C43217
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352889AbiDNOeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245043AbiDNNiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:38:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD9B99ED4;
        Thu, 14 Apr 2022 06:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCFD6B8296A;
        Thu, 14 Apr 2022 13:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252E9C385A5;
        Thu, 14 Apr 2022 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649943090;
        bh=Utz1YvWbSMLmkIEVCdwmAdUPQ3ARE9UXbQLDcRmNtww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bPrjwA9pRSkFBdxInZ8Pbk9G/Y1N45reHGPRIIZGKSxH7x0mXjxPifP+ODf7dSvGm
         YnBG0hfuwuqoA0dUwGbAhTGmx+P+9+cFGYMp5rQh0L7HLR2/Z1R6qao4p5rQ3PSygL
         OB330XhaOpSPAVlsNrt+oXHRT7kW5tRv49svW0Dk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 5.4 031/475] KEYS: fix length validation in keyctl_pkey_params_get_2()
Date:   Thu, 14 Apr 2022 15:06:56 +0200
Message-Id: <20220414110856.026406958@linuxfoundation.org>
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

From: Eric Biggers <ebiggers@google.com>

commit c51abd96837f600d8fd940b6ab8e2da578575504 upstream.

In many cases, keyctl_pkey_params_get_2() is validating the user buffer
lengths against the wrong algorithm properties.  Fix it to check against
the correct properties.

Probably this wasn't noticed before because for all asymmetric keys of
the "public_key" subtype, max_data_size == max_sig_size == max_enc_size
== max_dec_size.  However, this isn't necessarily true for the
"asym_tpm" subtype (it should be, but it's not strictly validated).  Of
course, future key types could have different values as well.

Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
Cc: <stable@vger.kernel.org> # v4.20+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/keys/keyctl_pkey.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -135,15 +135,23 @@ static int keyctl_pkey_params_get_2(cons
 
 	switch (op) {
 	case KEYCTL_PKEY_ENCRYPT:
+		if (uparams.in_len  > info.max_dec_size ||
+		    uparams.out_len > info.max_enc_size)
+			return -EINVAL;
+		break;
 	case KEYCTL_PKEY_DECRYPT:
 		if (uparams.in_len  > info.max_enc_size ||
 		    uparams.out_len > info.max_dec_size)
 			return -EINVAL;
 		break;
 	case KEYCTL_PKEY_SIGN:
+		if (uparams.in_len  > info.max_data_size ||
+		    uparams.out_len > info.max_sig_size)
+			return -EINVAL;
+		break;
 	case KEYCTL_PKEY_VERIFY:
-		if (uparams.in_len  > info.max_sig_size ||
-		    uparams.out_len > info.max_data_size)
+		if (uparams.in_len  > info.max_data_size ||
+		    uparams.in2_len > info.max_sig_size)
 			return -EINVAL;
 		break;
 	default:
@@ -151,7 +159,7 @@ static int keyctl_pkey_params_get_2(cons
 	}
 
 	params->in_len  = uparams.in_len;
-	params->out_len = uparams.out_len;
+	params->out_len = uparams.out_len; /* Note: same as in2_len */
 	return 0;
 }
 


