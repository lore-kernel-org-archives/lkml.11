Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6B7C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 15:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiCCP4m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 10:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiCCP4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:56:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8A4141E06;
        Thu,  3 Mar 2022 07:55:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A832D60C2C;
        Thu,  3 Mar 2022 15:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8E0C004E1;
        Thu,  3 Mar 2022 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646322954;
        bh=InC9xaVPcWhBcn1swTSH2FFWicOR2y5qBtTa3QQr7uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hClBiL+Ltur/DgONFRhoVM3OfVvvCPyF0ICITY2WNLgTqvYz96QZ6lVWz+Qo99kbG
         u7hwyD/HcYK2ECx77U6JkCFttjTzZZShwyz/YRtDNYRdYz2nP6NgzupPw8HN6T4CJn
         SaJI4UjmXESWPF9LcPHF9XJixKu3qRZu7fx1OsAnhHJGjmERghjOHQnspL8RqnK/KO
         wKxpVwIm5omY6VxwXyfgwefu3ReEvBJTTMa1G3+SqLywkHHpbMYNn5PGLQoyyF+RAE
         I8ccgP3K7he+0RNDH2WrSBP9r9U3ryTKHCdeweHbjZ2OUKf4m+V8wE7QbLnVkPvfte
         oVbWJ5K7mTm8g==
Date:   Thu, 3 Mar 2022 21:25:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_srivasam@quicinc.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] soundwire: qcom: fix build failures if CONFIG_PM=n
Message-ID: <YiDlBevX3/BrXmwb@matsya>
References: <20220303110321.23666-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303110321.23666-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-03-22, 11:03, Srinivas Kandagatla wrote:
> Fix below build failure
> drivers/soundwire/qcom.c:1460:12: error: 'swrm_runtime_resume' defined
> but not used [-Werror=unused-function]
> by marking the resume swrm_runtime_resume() with  __maybe_unused attribute.

A patch title should reflect the change and not the cause. So i have
taken liberty to fix it as:

soundwire: qcom: use __maybe_unused for swrm_runtime_resume() 
 
swrm_runtime_resume() would not be defined when CONFIG_PM=n
 
This causes below build failure
drivers/soundwire/qcom.c:1460:12: error: 'swrm_runtime_resume' defined
but not used [-Werror=unused-function]
 
Mark the resume swrm_runtime_resume() with  __maybe_unused attribute.

With this i have applied

-- 
~Vinod
