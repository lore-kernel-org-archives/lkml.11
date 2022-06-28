Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37665CCA47E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 20:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiF1UOZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 16:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiF1UNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:13:48 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C366251
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:07:37 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id i194so13936920ioa.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FirkMQlU16ww9d8QYtTZzYI9G8XOC3cBBLG3qPWT9SM=;
        b=NXQqbWdAG0cVqj1DgUmEfns18Gpsgf3sg7QR6IdprmL/oVpPpfCBXATjIfZd0uCQvH
         vWu5mS8R3Gf1cyKRVuNSWFpAA5NVGSxjnsGqcRXlHeQwqdauN1r7TD90glSIzTvQYXeN
         TRfLk7tzj1mVVU20YAE55y/PFIuiFPSUtvR+Fq4coa+IzhItx1gaOp1n+EOqrW836P1S
         hpYmNqGKez0q5iAIzcIL79FBpjToT2BmQeyKggVYc9EXg/3q/E6TWSQ834adALNQfTrb
         +4idenH0NMJBlHt5pNz+D8pA6aFVTj+zSGZYZLeYhRxLLPoHu+02WrhPoDcoFBLYaHAl
         w2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FirkMQlU16ww9d8QYtTZzYI9G8XOC3cBBLG3qPWT9SM=;
        b=et/hV+3qgJpb73sMSXD6/31WqJFTgYA4z0CLe5mMOQq3cqjjy3ddAXXuWiABIZAdKZ
         VKUyWrai/0ei0ADqrq6C/zhNqQlya1gbTEh30vz7Pso7aPdNMoJIAE1TuuQ2D0uDbMxy
         tO9uywZ00kHQ4+7ByNFS5/JavMT60Sgt1bBlwvAreObXpHHZMEjKTuTRTN7YNRLdN5ei
         nQFrgwd0VQm89Y7qR/Cf2es03WcjJceZ6QRVDkTadzHyRBpUrAbMQTz2Q+1tCKq4SuCa
         KgJvI+fhS/VDXZufNyWrPeVz69UDpGKMOOFe/20L98ETPCz5+YFKETpoFhsQ6ptPIn3D
         fQGQ==
X-Gm-Message-State: AJIora8JF/CZZ5PW+7aCtTsNEPmZ9eosyWSKdqw50UvdNnn72/yUSHhD
        9ao2zXjO3KXWmBvQmeetaHzlnk0WDe8=
X-Google-Smtp-Source: AGRyM1u23Wgi31gt74vfkBDWMlvLHSnnLRjUKZ+GLx/xUlBuiyhbNqOwBvl1ax1kCawjHG9fBkryzQ==
X-Received: by 2002:a6b:794d:0:b0:66c:ec39:7d83 with SMTP id j13-20020a6b794d000000b0066cec397d83mr10694476iop.199.1656446856717;
        Tue, 28 Jun 2022 13:07:36 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:53c6:a969:5c7a:edc0])
        by smtp.gmail.com with ESMTPSA id c18-20020a92c8d2000000b002d8f62d2e3bsm5943793ilq.86.2022.06.28.13.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:07:35 -0700 (PDT)
Sender: Seth Forshee <seth.forshee@gmail.com>
From:   Seth Forshee <seth@forshee.me>
X-Google-Original-From: Seth Forshee <sforshee@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: update Seth Forshee's email address
Date:   Tue, 28 Jun 2022 15:07:34 -0500
Message-Id: <20220628200734.424495-1-sforshee@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seth.forshee@canonical.com is no longer valid, use sforshee@kernel.org
instead.

Signed-off-by: Seth Forshee <sforshee@kernel.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 2ed1cf869175..56ce99212f33 100644
--- a/.mailmap
+++ b/.mailmap
@@ -368,6 +368,7 @@ Sean Nyekjaer <sean@geanix.com> <sean.nyekjaer@prevas.dk>
 Sebastian Reichel <sre@kernel.org> <sebastian.reichel@collabora.co.uk>
 Sebastian Reichel <sre@kernel.org> <sre@debian.org>
 Sedat Dilek <sedat.dilek@gmail.com> <sedat.dilek@credativ.de>
+Seth Forshee <sforshee@kernel.org> <seth.forshee@canonical.com>
 Shiraz Hashim <shiraz.linux.kernel@gmail.com> <shiraz.hashim@st.com>
 Shuah Khan <shuah@kernel.org> <shuahkhan@gmail.com>
 Shuah Khan <shuah@kernel.org> <shuah.khan@hp.com>
-- 
2.34.1

