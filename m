Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982EFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 08:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350157AbiDSIwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 04:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242241AbiDSIw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:52:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9A6C04
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:49:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y20so11292315eju.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8hjrVDl8143wwwhBJylNC8I9SW8bq2v5T1Q4KEXRiCk=;
        b=qw7rBuuWcTzFpbcO9VjR1eEowEwsuDBKQlB9/YSTU16JWyHPaE3ijY7uJC+spRnM9N
         uqz0D0GYdA4hQTK+HE4PXeewf+B/XfUPux55VflUFRIpKcCxJrNgGZRh6EYNlRI15fsA
         hLiYh0sr1SoceH0EjmQRmEfInZIdgxNBronFIwrm8LkV29P9eTWXagBrElkJBUJ8KuID
         ECMpIUOqn15NSVAmTaa71U+DrwI/bnAPjMIvFDGpbTCXsGZNRHJINNYS4cOdRJZxYzqU
         6pZm4/vaKq3+uLWJJu7WmJcLnRtW33F3ZuujdC/4Kd8rhgjt7tSVYIPetNTv57/x1Rah
         rzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8hjrVDl8143wwwhBJylNC8I9SW8bq2v5T1Q4KEXRiCk=;
        b=uk5OYBflX2sXwjb9L7drRzqxdAlzRjpOaN5vhbrFdzMeOnOalzJn3ayhJ86sn6RxCt
         rlHbyKjTgizl5bgE49XGu78y2y8gpHV0a1iG1x832qVIUHtn6ElpJSfQ8CTxXMewnPSt
         GKqtEq4stLE8dSB9OlvWXG2EGx8iEXzi3qZMdWVXityMe6EbAaFOpyZqy0HpDdiqtO+7
         s0o+Pi0XvvGwNbF38LaSL4ZcAeMl/lVNhdLcR1E8mkgXxcxYKcKoSe7HsOx13dgiEIXU
         N1tO92L4VJ/H08VDHYl0HlIO0/6WZmZYnMWxqQWAFnlvVawvqzFH0lGDLZthXBOpy7YM
         JsgQ==
X-Gm-Message-State: AOAM533pK+4RgVI8S3ReOuuK2MfoYhXbyyrXw15rQ4rqKBwB6+x9p3Nt
        K6zkjzB7AukNPJnifu8RvewSg/lkOgVIKg==
X-Google-Smtp-Source: ABdhPJwdZJICXWTMB6+u5bWzIGXt+3wB9h6w5bbWDE/3ior9cp9XX39CB2+0iRJapCPcVAJOFUSVPA==
X-Received: by 2002:a17:907:3e11:b0:6e8:cccd:de80 with SMTP id hp17-20020a1709073e1100b006e8cccdde80mr10671241ejc.162.1650358185401;
        Tue, 19 Apr 2022 01:49:45 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l21-20020a056402125500b004228541116esm6342072edw.28.2022.04.19.01.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 01:49:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] docs: dt: writing-schema: mention yamllint
Date:   Tue, 19 Apr 2022 10:49:42 +0200
Message-Id: <20220419084942.27409-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dtschema uses yamllint, if present, to check the syntax of the
files, so document this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/writing-schema.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
index 2916edf829db..4a381d20f2b4 100644
--- a/Documentation/devicetree/bindings/writing-schema.rst
+++ b/Documentation/devicetree/bindings/writing-schema.rst
@@ -134,6 +134,8 @@ installed first. On Debian/Ubuntu systems::
 Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
 installed. Ensure they are in your PATH (~/.local/bin by default).
 
+Recommended is also to install yamllint (used by dtschema when present).
+
 Running checks
 ~~~~~~~~~~~~~~
 
-- 
2.32.0

