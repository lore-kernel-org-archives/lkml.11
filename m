Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892B1C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 19:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351182AbiHSTRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 15:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349775AbiHSTRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:17:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC0F112328
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:17:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E867614FA
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 19:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB497C433C1;
        Fri, 19 Aug 2022 19:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660936620;
        bh=UD5jorQCVmKiXH0v3VkIP3iO7pPTI+aaxJhMgfUmopA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9CcfJrr7DxVuuS2Gm2gZKvuwOvb+Vz+Rdqox19HpJlD9HehiRHIKfbSsmysWdFki
         QMfhZwXQ6C23lVf64npGGtYo7lYWW47CemDU+OqUWI+4kuuXHPuHXC0QIfxEZqQX0d
         2DMe3lsL/uFuvHi/k38ThCvd5mHnGbXKMyRtrDCSYfeWWA/IsBk1h2vTo+fTi08a9w
         YORwgDQWyF5nHWba19ZdaHlYoIqo9e2dPdXDOEYLsevW1VGtSie91GKpvo+2dzj/V9
         9HPFEFeRvhirUxhMPmeyFh+9yNwCbBbYgjBhBLxyEhL8cdLlX0G3NT/GHazrSrWdGc
         aX2ZmQfbdybdA==
Received: by pali.im (Postfix)
        id DCB032821; Fri, 19 Aug 2022 21:16:57 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sinan Akman <sinan@writeme.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] powerpc/85xx: Mark mpc85xx_rdb_pic_init() as static
Date:   Fri, 19 Aug 2022 21:15:51 +0200
Message-Id: <20220819191557.28116-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220819191557.28116-1-pali@kernel.org>
References: <20220819191557.28116-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function mpc85xx_rdb_pic_init() is not used out of the mpc85xx_rdb.c file.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index d99aba158235..b6129c148fea 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -38,7 +38,7 @@
 #endif
 
 
-void __init mpc85xx_rdb_pic_init(void)
+static void __init mpc85xx_rdb_pic_init(void)
 {
 	struct mpic *mpic;
 
-- 
2.20.1

