Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A220C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 18:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244775AbiCGSaa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 13:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiCGSa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:30:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACECB29CAE;
        Mon,  7 Mar 2022 10:29:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C01F153B;
        Mon,  7 Mar 2022 10:29:31 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F0793FA45;
        Mon,  7 Mar 2022 10:29:30 -0800 (PST)
Date:   Mon, 7 Mar 2022 18:29:28 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: juno: align pl330 node name with dtschema
Message-ID: <YiZPCHtpmzNPEKt3@bogus>
References: <20220129175621.299254-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129175621.299254-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 06:56:21PM +0100, Krzysztof Kozlowski wrote:
> Fixes dtbs_check warning:
> 
>   dma@7ff00000: $nodename:0: 'dma@7ff00000' does not match '^dma-controller(@.*)?$'
>

Sorry for the delay, obviously I missed this. Looks fine for me.
I see you have already sent pull request which is good as I don't
have any other juno DTS patch at the moment.

Just in case it helps SoC team to pull you PR,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
