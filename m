Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E0FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 12:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350153AbiCXM2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350066AbiCXM2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F6CA94CA;
        Thu, 24 Mar 2022 05:27:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3DE761A74;
        Thu, 24 Mar 2022 12:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3059C340EC;
        Thu, 24 Mar 2022 12:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648124822;
        bh=TmiOD0TyVB864q6sOAv66BAybybMZ1pjdkIToQarHJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y4AaDNP1jIPhuUeM+bdDxNIEYkKDWYoySck+wKbUoqnhMIQ/oel4a778ba1qU75zP
         RRqvzRnjW5rR7U1YrXHHXyB4LSVG2hqeXOhlH0Y18Fin+FogwE3T1SCw5VsR5bgC9P
         3mA8JmooK5lnkeV62e2Jdln3kOaJxbf6K7GrQxeE=
Date:   Thu, 24 Mar 2022 13:26:59 +0100
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
Subject: Re: [PATCH v4 06/10] docs: sysfs: coresight: Add sysfs ABI
 documentation for TPDM
Message-ID: <Yjxjk8bB1ibHT7Ga@kroah.com>
References: <20220324121734.21531-1-quic_jinlmao@quicinc.com>
 <20220324121734.21531-7-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324121734.21531-7-quic_jinlmao@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 08:17:30PM +0800, Mao Jinlong wrote:
> Add API usage document for sysfs API in TPDM driver.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm | 5 +++++
>  1 file changed, 5 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> new file mode 100644
> index 000000000000..1df2f9b9ade2
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -0,0 +1,5 @@
> +What:		/sys/bus/coresight/devices/<tpdm-name>/integration_test
> +Date:		February 2022

It is no longer February.

> +KernelVersion	5.17

5.17 is long past.

> +Contact:	Jinlong Mao or Tao Zhang

How do we contact these names?

> +Description:	(Write) Run integration test for tpdm.

I do not understand this description at all.  Please explain it much
better.

thanks,

greg k-h
