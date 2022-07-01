Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76498C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 13:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiGANpe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 09:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiGANpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:45:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CD1C24958
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 06:45:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0490113E;
        Fri,  1 Jul 2022 06:45:13 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F2B53F800;
        Fri,  1 Jul 2022 06:45:12 -0700 (PDT)
Date:   Fri, 1 Jul 2022 14:45:09 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vincent.guittot@linaro.org, f.fainelli@gmail.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/5] firmware: arm_scmi: Support only one single
 SystemPower device
Message-ID: <20220701134509.e6wk3vwhimqre6h5@bogus>
References: <20220623124742.2492164-1-cristian.marussi@arm.com>
 <20220623124742.2492164-3-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623124742.2492164-3-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:47:39PM +0100, Cristian Marussi wrote:
> In order to minimize SCMI platform fw-side complexity, only one single SCMI
> platform should be in charge of SCMI SystemPower protocol communications
> with the OSPM: enforce the existence of one single unique device associated
> with SystemPower protocol across any possible number of SCMI platforms, and
> warn if a system tries to register different SystemPower devices from
> multiple platforms.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/bus.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> index a7cbf4d09081..476855d3dccb 100644
> --- a/drivers/firmware/arm_scmi/bus.c
> +++ b/drivers/firmware/arm_scmi/bus.c
> @@ -19,6 +19,11 @@ static DEFINE_IDA(scmi_bus_id);
>  static DEFINE_IDR(scmi_protocols);
>  static DEFINE_SPINLOCK(protocol_lock);
>  
> +/* Track globally the creation of SCMI SystemPower related devices */
> +static bool scmi_syspower_registered;
> +/* Protect access to scmi_syspower_registered */
> +static DEFINE_MUTEX(scmi_syspower_mtx);
> +

Since we create device from the driver, can't we do this from there
and keep the bus code free from handling all these special conditions
which are checked for each device creation.

Yes scmi_device_create can be called outside the exiting code but since it
is not exported(yet), we can assume all users are in kernel and we can
catch that if anyone attempts to add. And probably we don't need the lock
as well if it is taken care in the single loop creating the device.

-- 
Regards,
Sudeep
