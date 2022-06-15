Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762B2C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 14:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiFOOtP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 10:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiFOOtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:49:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CB130F6F;
        Wed, 15 Jun 2022 07:49:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C905B81DEE;
        Wed, 15 Jun 2022 14:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8827BC34115;
        Wed, 15 Jun 2022 14:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655304548;
        bh=X+hXgNyb7gc/ZkrILIfLEocswl6gl3ou4Isn8SrYXHc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qSThpeLcfdXfTzH8gCG1RS7bYGVZ7pByf2elVpXS/viuLIU+qjSriuHzEjl3xnu4R
         v9Fwer+0M2XxpOFq/uh04o/NjsCCrV/dlmxHcA+v/QW0VQItOe45Qlm1Ak3pRvNjOf
         ExDavhl5ShoWCcVZhnn4hpkIHabVbkuSdHI1jqGq6XVNXu1MZIZICX7UHlIVqQAWT2
         xXhy8RuMlNkllsRReyn1Upa70IfQSZ1ZhKiJIJLvL+CDGcCCLb/NKOeqpxFQVqH0cB
         sHvZzH+JejJIUl5w85Hq4xa79WNBjKkNeJmFsuMduQjgXE2p5r+r/c0+tjN7rIhLqg
         R0QerY80fYHJQ==
Message-ID: <df00d3ac-83c4-d9a9-6e09-c6e0a626edd6@kernel.org>
Date:   Wed, 15 Jun 2022 09:49:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3] arm64: dts: Add support for Stratix 10 Software
 Virtual Platform
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        wen.ping.teh@intel.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220609025500.400695-1-wen.ping.teh@intel.com>
 <c7e2cbad-9e6d-a089-0507-8d1f69c5e6a5@linaro.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <c7e2cbad-9e6d-a089-0507-8d1f69c5e6a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/22 18:25, Krzysztof Kozlowski wrote:
> On 08/06/2022 19:55, wen.ping.teh@intel.com wrote:
>> From: Teh Wen Ping <wen.ping.teh@intel.com>
>>
>> Add Stratix 10 Software Virtual Platform device tree
>>
>> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
>> ---
>>
>> changes in v2:
>> -remove indentation before GPL
>> -change root compatible to "altr,socfpga-stratix10"
>> -remove bootargs
>> -move clock-frequency to label
>> -remove l2-cache
>> -remove no longer exist authors from commit message
>>
>> changes in v3:
>> -change root compatible to "altr,socfpga-stratix10-swvp"
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 

Applied!

Thanks,
Dinh
