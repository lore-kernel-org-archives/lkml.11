Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3F0C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 07:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiF3HKv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 03:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiF3HKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:10:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C19482FFE9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:10:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9E6A1BCA;
        Thu, 30 Jun 2022 00:10:48 -0700 (PDT)
Received: from [10.162.41.8] (unknown [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9232D3F66F;
        Thu, 30 Jun 2022 00:10:46 -0700 (PDT)
Message-ID: <d4b409dc-b388-187d-4792-24909048a9ab@arm.com>
Date:   Thu, 30 Jun 2022 12:40:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] arm64: defconfig: Enable memory hotplug and hotremove
 config
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220629093524.34801-1-wangkefeng.wang@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220629093524.34801-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/22 15:05, Kefeng Wang wrote:
> Let's enable ACPI_HMAT, ACPI_HOTPLUG_MEMORY, MEMORY_HOTPLUG
> and MEMORY_HOTREMOVE for more test coverage, also there are
> useful for heterogeneous memory scene.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2: add ACPI_HMAT and update changelog too.

In general, would like to see MEMORY_HOTPLUG/HOTREMOVE be selected
here for better memory hotplug test coverage. But not sure whether
there had been a rationale for not enabling this on defconfig.

>  arch/arm64/configs/defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7d1105343bc2..78add6eefa2b 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -101,6 +101,8 @@ CONFIG_ARM_TEGRA186_CPUFREQ=y
>  CONFIG_ARM_MEDIATEK_CPUFREQ=y
>  CONFIG_QORIQ_CPUFREQ=y
>  CONFIG_ACPI=y
> +CONFIG_ACPI_HOTPLUG_MEMORY=y
> +CONFIG_ACPI_HMAT=y
>  CONFIG_ACPI_APEI=y
>  CONFIG_ACPI_APEI_GHES=y
>  CONFIG_ACPI_APEI_PCIEAER=y
> @@ -125,6 +127,8 @@ CONFIG_SECCOMP=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> +CONFIG_MEMORY_HOTPLUG=y
> +CONFIG_MEMORY_HOTREMOVE=y
>  CONFIG_KSM=y
>  CONFIG_MEMORY_FAILURE=y
>  CONFIG_TRANSPARENT_HUGEPAGE=y
