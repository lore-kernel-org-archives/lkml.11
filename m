Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B762C4332F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 17:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384215AbiBHRh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 12:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352907AbiBHRhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:37:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F1FC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:37:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B5A0617CC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 17:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1672C340ED;
        Tue,  8 Feb 2022 17:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644341843;
        bh=zoVcBqBlFwWw4RwkCbOIV8HYffhswg6RiqAJtljMnUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3AoQVNnP7igB2TprzpCi2ThBw0PugrptAC7v0i6BjLMB9THldE31bY6T/6GWTxLa
         AgUbFb1y2lpN+ptzuAF0hcilHqg7AiFR83ydAzQzWf9y6+bcXT3oz+5BzPXeGj/rNF
         lq92p4pWyYhWFGHsP1f9T1+K2LJoCXykOFqb6waeAWpsgAqZTDgL4hcFySIMTtkORK
         Gbghp790s7OK6Ox8FpAszG8CB5u3c0tqRvJmRjta8yRQU9+DFsaqs1QzeBzmHCLryB
         f+NspBdl1yc3LELltLmR6OLeuNrlQp1V9vID7GmdImhuAU3GK44KTLPg4T4GxN9Ydr
         oCrprPUC70RMg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHUQb-006KsD-Pi; Tue, 08 Feb 2022 17:37:21 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Keir Fraser <keirf@google.com>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Fuad Tabba <tabba@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Quentin Perret <qperret@google.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2] KVM: arm64: pkvm: Implement CONFIG_DEBUG_LIST at Hyp
Date:   Tue,  8 Feb 2022 17:37:20 +0000
Message-Id: <164434147328.3931943.15101620519718026308.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220131124114.3103337-1-keirf@google.com>
References: <20220131124114.3103337-1-keirf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: keirf@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com, tabba@google.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, samitolvanen@google.com, qperret@google.com, will@kernel.org, keescook@chromium.org, james.morse@arm.com, alexandru.elisei@arm.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 12:40:53 +0000, Keir Fraser wrote:
> Currently the check functions are stubbed out at EL2. Implement
> versions suitable for the constrained EL2 environment.

Applied to next, thanks!

[1/1] KVM: arm64: pkvm: Implement CONFIG_DEBUG_LIST at Hyp
      commit: 4c68d6c0a1757139c791ccf1a781cbd81e35a063

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


