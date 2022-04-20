Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02EDC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 12:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378559AbiDTMeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 08:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378580AbiDTMeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:34:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6BA41615;
        Wed, 20 Apr 2022 05:31:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54137B81ED1;
        Wed, 20 Apr 2022 12:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34703C385A1;
        Wed, 20 Apr 2022 12:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650457888;
        bh=xFBxXROoKf7u+JAvuiZg1qFNSkoOxNBQ8DLIUz0UXt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VvD6eMwnKgud8prkIqkDyIzKkAwnMUG4UDyyfYe5GozZoG+JQD9ZC+MWEawYLhELH
         0hs82Censkr6ZKriGuk5xCI8kZvqNjS2ShtpnewUZGs/rHnoy7JER51sXpcFOHyHJd
         4w+zU+Ph3yxGaGChG7V0qCp4ZV33CvLWCyxvRqHGJgCMa3G6ckchns1V8GDedi7lls
         x9z5xtoClxAUKqZt9X+vrgmAIL0TCf+Td8S1Xd/FyCAytoUxrZ4tVXTsZaH6oZw9SI
         L7UBS0eW7oRNR9gmS8JUdYIodtOY26V6MAWwBDUsh1SnJ6sjmEgj/wBJ4T44IezRCD
         6O7NfTrnHhCGg==
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org, jgg@ziepe.ca, robin.murphy@arm.com,
        Nicolin Chen <nicolinc@nvidia.com>, jean-philippe@linaro.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, stable@vger.kernel.org,
        jacob.jun.pan@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, fenghua.yu@intel.com,
        iommu@lists.linux-foundation.org, rikard.falkeborn@gmail.com,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix size calculation in arm_smmu_mm_invalidate_range()
Date:   Wed, 20 Apr 2022 13:31:21 +0100
Message-Id: <165044753398.180787.4069543281631212706.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220419210158.21320-1-nicolinc@nvidia.com>
References: <20220419210158.21320-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 14:01:58 -0700, Nicolin Chen wrote:
> The arm_smmu_mm_invalidate_range function is designed to be called
> by mm core for Shared Virtual Addressing purpose between IOMMU and
> CPU MMU. However, the ways of two subsystems defining their "end"
> addresses are slightly different. IOMMU defines its "end" address
> using the last address of an address range, while mm core defines
> that using the following address of an address range:
> 
> [...]

Applied to will (for-joerg/arm-smmu/fixes), thanks!

[1/1] iommu/arm-smmu-v3: Fix size calculation in arm_smmu_mm_invalidate_range()
      https://git.kernel.org/will/c/95d4782c34a6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
