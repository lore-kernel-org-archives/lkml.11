Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDB1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jan 2022 10:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346830AbiAGK5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jan 2022 05:57:09 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55074 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346728AbiAGK5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:57:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F1020CE29BE;
        Fri,  7 Jan 2022 10:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2789C36AE9;
        Fri,  7 Jan 2022 10:57:01 +0000 (UTC)
Date:   Fri, 7 Jan 2022 10:56:58 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/7] arm64: Add Cortex-A510 CPU part definition
Message-ID: <YdgcegdfpV6eCvXl@arm.com>
References: <1641517808-5735-1-git-send-email-anshuman.khandual@arm.com>
 <1641517808-5735-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641517808-5735-2-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 06:40:02AM +0530, Anshuman Khandual wrote:
> Add the CPU Partnumbers for the new Arm designs.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
