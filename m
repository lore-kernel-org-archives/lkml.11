Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACE6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 10:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbiFNKOJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 06:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiFNKOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:14:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C75646157;
        Tue, 14 Jun 2022 03:14:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6A4323A;
        Tue, 14 Jun 2022 03:14:06 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 753483F792;
        Tue, 14 Jun 2022 03:14:05 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: arm/fvp-base-revc: Remove 'panel-dpi' compatible
Date:   Tue, 14 Jun 2022 11:14:03 +0100
Message-Id: <165520087950.1030128.13080682792301957052.b4-ty@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610204057.2203419-1-robh@kernel.org>
References: <20220610204057.2203419-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 14:40:57 -0600, Rob Herring wrote:
> The rtsm-display panel timing node was removed in commit 928faf5e3e8d
> ("arm64: dts: fvp: Remove panel timings"). Without the node, 'panel-dpi'
> is not needed either.
>

Applied to sudeep.holla/linux (for-next/juno), thanks!

[1/1] arm64: dts: arm/fvp-base-revc: Remove 'panel-dpi' compatible
      https://git.kernel.org/sudeep.holla/c/7fc96d7162

--
Regards,
Sudeep

