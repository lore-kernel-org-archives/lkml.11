Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FD8C433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 09:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbiDEJFL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbiDEIS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:18:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54BBB7C4D;
        Tue,  5 Apr 2022 01:07:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BC36B81B18;
        Tue,  5 Apr 2022 08:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B454FC385A0;
        Tue,  5 Apr 2022 08:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649146058;
        bh=qCT2fERxtkSUg8GxJqtC7W7Qj/xTGFXlgly/YuayjiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=agCe/HKiIe2PRKs7eqTsaFYHd+MZW1xr0F5pM/HA0AqEfIJ78Gidfo+AKC4/DHq3X
         WX2TO9PtTn45Q8lvOFzzho5Cf/NnvZFmAMWVp2obPzfIJdjsuiD12X0ktWuEvtOsaz
         jxYnaCI+EzpRcnUUFNtcWa56yN7PxufOsS7TH9YI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0626/1126] KVM: arm64: Enable Cortex-A510 erratum 2077057 by default
Date:   Tue,  5 Apr 2022 09:22:53 +0200
Message-Id: <20220405070426.011522620@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 4c11113c1a3d10f5b617e5d2b9acd8d1d715450f ]

The recently added configuration option for Cortex A510 erratum 2077057 does
not have a "default y" unlike other errata fixes. This appears to simply be
an oversight since the help text suggests enabling the option if unsure and
there's nothing in the commit log to suggest it is intentional.

Fixes: 1dd498e5e26ad ("KVM: arm64: Workaround Cortex-A510's single-step and PAC trap errata")
Signed-off-by: Mark Brown <broonie@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220225184658.172527-1-broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c842878f8133..baa0e9bbe754 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -683,6 +683,7 @@ config ARM64_ERRATUM_2051678
 
 config ARM64_ERRATUM_2077057
 	bool "Cortex-A510: 2077057: workaround software-step corrupting SPSR_EL2"
+	default y
 	help
 	  This option adds the workaround for ARM Cortex-A510 erratum 2077057.
 	  Affected Cortex-A510 may corrupt SPSR_EL2 when the a step exception is
-- 
2.34.1



