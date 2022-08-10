Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BC0C00140
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 14:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiHJOmC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 10:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiHJOl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:41:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADBD51419;
        Wed, 10 Aug 2022 07:41:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o22so19343315edc.10;
        Wed, 10 Aug 2022 07:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=XFsjrDHhcwmAj2TVK3rhCPmJ62iBuCLs+g1xt1QLbrY=;
        b=KBXotDFJQz5FwOXfOiIoNubeYa0m16EN1yFgYCNK2SUJ1U/FXxdf+nroWhUIGcpk07
         GgcAja6iIntTY1XGDsRyr6fi1vx2IzQK7LtE1pXtfSdgg7D6Uyk4+SNR+DK0LzYpmCBP
         InXz+6WLrnd6kxJzdsoqOwGPtGoMRx8QYxK0e8+VnWDqQphIfTxIjAJcxwpkjSp9aXe4
         K4fpv9I6hwjYVt//kozcqPRJfLsp5zRxkauf25gW/ZmbABA95GvtfwPZnJlrMinOUfMY
         kXot4UYME269uoDVifsIJwWolvYaRicYZlSdaQR9GEJNpa6SsUzO4XrYa07MmqNvYsoM
         JDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=XFsjrDHhcwmAj2TVK3rhCPmJ62iBuCLs+g1xt1QLbrY=;
        b=SqcqAoHSUy9XguUfMgLfbxc9US00dYSx7CWQCqEYS8qCkeHfDqbrBPEJwx0VC3evWJ
         o+4b5ia4FZq7UkcHYJf+Vezw7cQ9CyYXlNd8nTdJn1boYDQSTsJ9nlKtS8UC9hLBS23U
         IvUsfcH+shM8RdWObeL7NdS/89y33FiMuyKvtYZWtHIYQgfFXlYPxsEHUSblwzPSa6t2
         mPbKBrv+xgNutbW4kDcXFwxZAwzOISsbX8swbwH2VkdfGbnBII5B0KbRQn64yMwSEp4I
         Xs+clXAdAHQW27btexByq5B/S/RrLVOVYExRx4x99uBGLJUDvfWYXqT9pwu3h4S5u3Q1
         FowQ==
X-Gm-Message-State: ACgBeo0v4EUDuY45MaRpXSwyLtpq3WJQKPWUvwo5XHetECsgunLSRcv7
        CSXuLYXp/phDsssix9hDuj8=
X-Google-Smtp-Source: AA6agR50nMIHqoJpTZrPNq7NO9hfuvf5CFnw+/kcffxJt+q7bYO/sYSCriCkRV06yWnK0Nf3BPSuiA==
X-Received: by 2002:a05:6402:190b:b0:43d:d001:2cce with SMTP id e11-20020a056402190b00b0043dd0012ccemr26528876edz.326.1660142500232;
        Wed, 10 Aug 2022 07:41:40 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id d25-20020aa7d699000000b0043cedad30a5sm7778049edr.21.2022.08.10.07.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 07:41:39 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 0/3] platform/surface: aggregator_registry: Rename and add more HID device nodes
Date:   Wed, 10 Aug 2022 16:41:14 +0200
Message-Id: <20220810144117.493710-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is twofold:

Patch 1 and 2 rename existing HID firmware nodes to better reflect the
devices they represent and the hierarchy they are placed under. In
particular, the three previously unknown nodes are for sensors, firmware
updates via the CFU mechanism, and for a USB Type-C Connector System
Software Interface (UCSI) HID client.

Patch 3 adds support for sensors and the UCSI client to the Surface Pro
8 by adding the missing SAM-connected HID nodes.

Regards,
Max

Maximilian Luz (3):
  platform/surface: aggregator_registry: Rename HID device nodes based
    on their function
  platform/surface: aggregator_registry: Rename HID device nodes based
    on new findings
  platform/surface: aggregator_registry: Add HID devices for sensors and
    UCSI client to SP8

 .../surface/surface_aggregator_registry.c     | 44 ++++++++++---------
 1 file changed, 23 insertions(+), 21 deletions(-)

-- 
2.37.1

