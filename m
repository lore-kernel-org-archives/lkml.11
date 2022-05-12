Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34099C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 00:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349678AbiELAan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 20:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346263AbiELAak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:30:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DD659BA1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:30:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n6-20020a254006000000b0064b2e352561so3291468yba.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0J8P1K+Pc+pMnOB9fJOxIgGn/5rddsTWXBmrJCDpNWM=;
        b=VFKsYXv0v7lf3Bb8KTBlngA69IfwQBf46pJBZBZHyFkYBg+y3q9KMyOSSHXd/CbiNd
         r2f3orVJWoJb72ZMl9iUABXlzMcOGk6Qwx1+QmuEMKHbv5BT/XcyJcsyPjvSUR91cCJP
         HLh5wA6uTAYDieGWE99apmQW09fkPrUr4qnvOEocpi2MYPfkPgT/0NY4LmOaU4seiU2U
         69sEvRRuP6TBiXVypVMdj4ISTEB/vuoMKu69EMQdx6lhMf4P93GUSmuwCvYX6cTUCY9b
         w2b0Ev3hj4hE3Yoqqw6LXnfOcK2IwtsRdxmDk6L0yvYwPbvGDaSphXmEDfaiv3KgxZp7
         J8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0J8P1K+Pc+pMnOB9fJOxIgGn/5rddsTWXBmrJCDpNWM=;
        b=EdZyjsbYVL8IpggWBtrzz/UZCiRmGYbWfBQxmMLrKm02dovR3zJJTm9IcYJeswQEFo
         wQo5mt9GAtPCG3x8sph0wA/5DAJHF/bb31AWFCivJvtNvgYnx4KgkUwMcNaU+z7y51Wy
         qbgiMhb89Evmpv5ykb1pkxsElQdtM2othMtVu79kRubZHPVub88hk+Ztd+oY07efjDVN
         Q3w0ZA3Wd1ennSHbjBWCdSz9e14JXgI2SSBbGDeJj4AqrTOnbQYjzQnr/B0nb/Dd4cpZ
         VQHdBdlP87Wfj8fxMqIX1PvFvrxCm1gAeap9CG22EqADKDIpODI5S1yjWdasiwSZT4Uj
         E6OQ==
X-Gm-Message-State: AOAM533e+xQY0mfdJRzf4xD1yK3n2D74FRXYKiXiCT129QnBF6TmoDwL
        Sh5XrJl1xoikUK+B+oBhaqUAy/xSmFEBb2RDJD6TGQ==
X-Google-Smtp-Source: ABdhPJztheMq4wek6bjRE3pjaXONWrS9xUmr/9I9m7eTyIKBdd/Pf3LX+0fKpge8zSFiJoMiStN2DF6ez48eaGwGgmtFAw==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:2bac:a878:d06e:e354])
 (user=brendanhiggins job=sendgmr) by 2002:a25:2106:0:b0:64b:2295:33a9 with
 SMTP id h6-20020a252106000000b0064b229533a9mr8834429ybh.289.1652315438880;
 Wed, 11 May 2022 17:30:38 -0700 (PDT)
Date:   Wed, 11 May 2022 17:30:26 -0700
Message-Id: <20220512003026.3413497-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v1] kunit: tool: update riscv QEMU config with new serial dependency
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config for the serial console for riscv,
CONFIG_SERIAL_EARLYCON_RISCV_SBI, added a dependency,
CONFIG_RISCV_SBI_V01, at some point, so add that in to the base arch
config.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/qemu_configs/riscv.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/kunit/qemu_configs/riscv.py b/tools/testing/kunit/qemu_configs/riscv.py
index 9e528087cd7c..a7a4ab8093b1 100644
--- a/tools/testing/kunit/qemu_configs/riscv.py
+++ b/tools/testing/kunit/qemu_configs/riscv.py
@@ -21,6 +21,7 @@ CONFIG_SOC_VIRT=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_RISCV_SBI_V01=y
 CONFIG_SERIAL_EARLYCON_RISCV_SBI=y''',
 			   qemu_arch='riscv64',
 			   kernel_path='arch/riscv/boot/Image',

base-commit: feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
-- 
2.36.0.550.gb090851708-goog

