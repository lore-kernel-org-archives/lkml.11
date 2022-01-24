Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E035C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jan 2022 10:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiAXKhi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jan 2022 05:37:38 -0500
Received: from foss.arm.com ([217.140.110.172]:57092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234250AbiAXKhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:37:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 152B16D;
        Mon, 24 Jan 2022 02:37:36 -0800 (PST)
Received: from [10.57.86.86] (unknown [10.57.86.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED9653F73B;
        Mon, 24 Jan 2022 02:37:34 -0800 (PST)
Message-ID: <ecfce441-d79d-4a6b-b8b1-c45619eff78f@arm.com>
Date:   Mon, 24 Jan 2022 10:37:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH V2 0/2] coresight: trbe: Update existing errata for
 Cortex-X2
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <1642994138-25887-1-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1642994138-25887-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2022 03:15, Anshuman Khandual wrote:
> Errata ARM64_ERRATUM_[2119858|2224489] also affect some Cortex-X2 ranges as
> well. This series updates the errata definition and detection as required.
> This series applies on v5.17-rc1.
> 
> Relevant identification document can be found here.
> 
> https://developer.arm.com/documentation/101803/0200/AArch64-system-registers/
> AArch64-identification-register-summary/MIDR-EL1--Main-ID-Register
> 
> Relevant errata document can be found here.
> 
> https://developer.arm.com/documentation/SDEN1775100
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 

For the series:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
