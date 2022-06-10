Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BE2C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 14:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349297AbiFJOsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 10:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345899AbiFJOr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:47:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FAF57523C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:47:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EDC01FB;
        Fri, 10 Jun 2022 07:47:45 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58D9A3F73B;
        Fri, 10 Jun 2022 07:47:44 -0700 (PDT)
Date:   Fri, 10 Jun 2022 15:47:34 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Ludvig =?iso-8859-1?Q?P=E4rsson?= <ludvig.parsson@axis.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, kernel@axis.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Fix incorrect error propagation
Message-ID: <YqNZhmeol/JvEvsB@e120937-lin>
References: <20220610140055.31491-1-ludvig.parsson@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220610140055.31491-1-ludvig.parsson@axis.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 04:00:55PM +0200, Ludvig Pärsson wrote:
> scmi_voltage_descriptors_get() will incorrecly return an
> error code if the last iteration of the for loop that
> retrieves the descriptors is skipped due to an error.
> Skipping an iteration in the loop is not an error, but
> the `ret` value from the last iteration will be
> propagated when the function returns.
> 
> Fix by not saving return values that should not be
> propagated. This solution also minimizes the risk of
> future patches accidentally reintroducing this bug.
> 
> Signed-off-by: Ludvig Pärsson <ludvig.parsson@axis.com>
> ---

Hi Ludvig,

you are right, good catch.

I would also say, reviewing this now, that the following line:

 ph->xops->reset_rx_to_maxsz

it is not called when skipping (even by the original code) BUT
this is not a problem given that VOLTAGE_DOMAIN_ATTRIBUTES is not
a command returning a variable length reply, so it really never
needed to reset the buffer size to max when called in a loop.
(almost all of these command are now embedded in the iterator
helpers that take care to call reset_to_maxsz on their own
internally)

I'll post a fix to remove that last unneeded line soon-ish.

In the meantime, regarding this patch instead:

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks for this,
Cristian

>  drivers/firmware/arm_scmi/voltage.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
> index 9d195d8719ab..49b75375d3ff 100644
> --- a/drivers/firmware/arm_scmi/voltage.c
> +++ b/drivers/firmware/arm_scmi/voltage.c
> @@ -225,9 +225,8 @@ static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
>  
>  		/* Retrieve domain attributes at first ... */
>  		put_unaligned_le32(dom, td->tx.buf);
> -		ret = ph->xops->do_xfer(ph, td);
>  		/* Skip domain on comms error */
> -		if (ret)
> +		if (ph->xops->do_xfer(ph, td))
>  			continue;
>  
>  		v = vinfo->domains + dom;
> @@ -249,9 +248,8 @@ static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
>  				v->async_level_set = true;
>  		}
>  
> -		ret = scmi_voltage_levels_get(ph, v);
>  		/* Skip invalid voltage descriptors */
> -		if (ret)
> +		if (scmi_voltage_levels_get(ph, v))
>  			continue;
>  
>  		ph->xops->reset_rx_to_maxsz(ph, td);
> -- 
> 2.20.1
> 
