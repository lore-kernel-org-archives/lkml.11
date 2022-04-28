Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EA7C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Apr 2022 10:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344368AbiD1KyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Apr 2022 06:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344727AbiD1Kx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:53:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A5B888E9;
        Thu, 28 Apr 2022 03:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4517F61E80;
        Thu, 28 Apr 2022 10:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA60C385A9;
        Thu, 28 Apr 2022 10:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651143042;
        bh=LVzxv0vhIjzR3WT/6NuMJqW2pJCpmSitE92sqMtl+6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t/mBpvezplxYCz9sVVM1MUFFkxkwzalTW3cUEVwBChFPjLVa6s0iBoIITIQ3t5IJu
         44KDYSPGtC5tXSARUZ6DjXh7n9DBEub8S822Rq5sCotpEwchnqD7eT40h3Uuwoqw9e
         6sMQnzuLCtLkd1sJPWM9kBRPERMaoxsxAcig9rN0=
Date:   Thu, 28 Apr 2022 12:50:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     arnd@arndb.de, catalin.marinas@arm.com, rostedt@goodmis.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, quic_psodagud@quicinc.com, quic_tsoni@quicinc.com,
        will@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCHv12 9/9] soc: qcom: geni: Disable MMIO tracing for GENI SE
Message-ID: <YmpxfqR0URy5yOAm@kroah.com>
References: <cover.1651139070.git.quic_saipraka@quicinc.com>
 <dc4efdf5f97b1ee43718d897c9d4b6256aedb4bc.1651139070.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc4efdf5f97b1ee43718d897c9d4b6256aedb4bc.1651139070.git.quic_saipraka@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 03:25:32PM +0530, Sai Prakash Ranjan wrote:
> Disable MMIO tracing for geni serial engine driver as it is a
> high frequency operation with many register reads/writes and
> not very useful to log all MMIO traces and prevent excessive
> logging.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 28a8c0dda66c..cd4ad16a8fa6 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -1,5 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> +/*
> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */

Same review comment here.

> +/* Disable MMIO tracing */
> +#define __DISABLE_TRACE_MMIO__

And here.

thanks,

greg k-h
