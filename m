Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B31C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 14:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiGAODP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 10:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiGAODM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:03:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86E3AE8B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:03:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 938B6113E;
        Fri,  1 Jul 2022 07:03:11 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BC693F792;
        Fri,  1 Jul 2022 07:03:09 -0700 (PDT)
Date:   Fri, 1 Jul 2022 15:03:07 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, daniel.lezcano@linaro.org,
        tarek.el-sherbiny@arm.com, adrian.slatineanu@arm.com,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        wbartczak@marvell.com
Subject: Re: [PATCH v3 5/9] firmware: arm_scmi: Make use of FastChannels
 configurable
Message-ID: <20220701140307.upgfn4qpxhl63syg@bogus>
References: <20220627123038.1427067-1-cristian.marussi@arm.com>
 <20220627123038.1427067-6-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627123038.1427067-6-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 01:30:34PM +0100, Cristian Marussi wrote:
> Add a Kernel configuration entry used to optionally disable, globally, the
> usage of SCMI FastChannels even on platforms where they are available.
> 
> Make such option default-no to preserve the original SCMI system behaviour
> of using any available FC.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v2 --> v3
> - fixed wording in Kconfig
> - reverted Kconfig logic _USE_ -> _AVOID_
> ---
>  drivers/firmware/arm_scmi/Kconfig  | 13 +++++++++++++
>  drivers/firmware/arm_scmi/driver.c |  6 ++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index 1e7b7fec97d9..3fb34db01014 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -42,6 +42,19 @@ config ARM_SCMI_HAVE_MSG
>  	  This declares whether a message passing based transport for SCMI is
>  	  available.
>  
> +config ARM_SCMI_AVOID_FASTCHANNELS
> +	bool "Avoid using SCMI FastChannels even when available"

Without default, won't this prompt user now ? I would have explicit default n
if we are adding this. But why do we need this is my question ? This would
be a quirk IMO on systems where FC is broken. I don't want people to enable
this during testing and ship f/w with FC broken(or not developed yet).

We can add this if some platforms really need this as a quirk in the future.
Thoughts ?

-- 
Regards,
Sudeep
