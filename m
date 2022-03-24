Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129CCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 12:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348787AbiCXM1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbiCXM1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:27:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA318CCE9;
        Thu, 24 Mar 2022 05:26:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAEA2B82258;
        Thu, 24 Mar 2022 12:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F45C340EC;
        Thu, 24 Mar 2022 12:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648124769;
        bh=I2cvejvvU5c4WuedgFx5yUyKh6RW99LNnSTXQFJ3M5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fq/QMjkvfFoV+2nA0jKO67K94gmzicWcevUnKx3Dv8c5YHCL7g9tUkFU0VuY0YehP
         8O0Hbqgf0HvG71RI51LZ4w5Wso+eaEWRXt6czhu6KdR2E4zwHqphxCWM0d8du3T6Wc
         R4Psi9HYaEAGarxFh4FlFJqxj4WZClaB7ctMlNHI=
Date:   Thu, 24 Mar 2022 13:26:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 01/10] Use IDR to maintain all the enabled sources'
 paths.
Message-ID: <YjxjXnXAXVXfZqr/@kroah.com>
References: <20220324121734.21531-1-quic_jinlmao@quicinc.com>
 <20220324121734.21531-2-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324121734.21531-2-quic_jinlmao@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 08:17:25PM +0800, Mao Jinlong wrote:
> Use hash length of the source's device name to map to the pointer
> of the enabled path. Using IDR will be more efficient than using
> the list. And there could be other sources except STM and CPU etms
> in the new HWs. It is better to maintain all the paths together.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 75 +++++++-------------
>  1 file changed, 26 insertions(+), 49 deletions(-)

Your subject line is odd.  Please put back the driver subsystem in the
subject line so that it makes more sense.

And how have you measured "more efficient"?

thanks,

greg k-h
