Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22230C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 13:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbiEXNxG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 09:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiEXNxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:53:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87F913D13;
        Tue, 24 May 2022 06:52:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C8C961638;
        Tue, 24 May 2022 13:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7786CC385AA;
        Tue, 24 May 2022 13:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653400378;
        bh=STLMhacHl2AWzy+G9RHYcojTiEvQVA6j5evH9G5s9Zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aEEVfvhTm/iy3uXXblT6eftV1oQ2Mqfmu5UZXpotce+AeLjMCEvLhcLq1NsAsx/mF
         9aOQyRAExiU3mqg+ztMj7KMAEvhotfcsymhln6gUjTpbSOzbYZRkhloVofrFPHyhPK
         H16n/uM1p5rW2jsGTk4+a3XQ9/bNdJCdIlC36l5BXqVwXCPfQCHdcyGAktMfhfAFWn
         9DGUkubUzDs8TPErx1UAkMRyTv8q9awK5O9U0vLaxyUxRtX2IHOsfQ0l0WF4tXqx7z
         +nxV/EuMPRIbdXyYZu2z6ycToGbqYucrk6oz9gjdwpQujyZrTp7InX9LMW7jWq+RTu
         CcoH1YQvrjEgQ==
Date:   Tue, 24 May 2022 19:22:50 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Prasad Sodagudi <quic_psodagud@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] mailbox: qcom-ipcc: Fix -Wunused-function with
 CONFIG_PM_SLEEP=n
Message-ID: <20220524135250.GC5745@thinkpad>
References: <20220523224702.2002652-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220523224702.2002652-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 03:47:02PM -0700, Nathan Chancellor wrote:
> When CONFIG_PM_SLEEP is not set, there is a warning that
> qcom_ipcc_pm_resume() is unused:
> 
>   drivers/mailbox/qcom-ipcc.c:258:12: error: 'qcom_ipcc_pm_resume' defined but not used [-Werror=unused-function]
>     258 | static int qcom_ipcc_pm_resume(struct device *dev)
>         |            ^~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
> 
> Commit 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old
> ones") reworked the PM_OPS macros to avoid this problem. Use
> NOIRQ_SYSTEM_SLEEP_PM_OPS directly so that qcom_ipcc_pm_resume() always
> appears to be used to the compiler, even though it will be dead code
> eliminated in the !CONFIG_PM_SLEEP case.
> 
> Fixes: c25f77899753 ("mailbox: qcom-ipcc: Log the pending interrupt during resume")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

My bad, I missed this. Thanks for the fix!

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/mailbox/qcom-ipcc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
> index 2583b20cdeb7..31d58b7d55fe 100644
> --- a/drivers/mailbox/qcom-ipcc.c
> +++ b/drivers/mailbox/qcom-ipcc.c
> @@ -344,7 +344,7 @@ static const struct of_device_id qcom_ipcc_of_match[] = {
>  MODULE_DEVICE_TABLE(of, qcom_ipcc_of_match);
>  
>  static const struct dev_pm_ops qcom_ipcc_dev_pm_ops = {
> -	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, qcom_ipcc_pm_resume)
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, qcom_ipcc_pm_resume)
>  };
>  
>  static struct platform_driver qcom_ipcc_driver = {
> 
> base-commit: bca1a1004615efe141fd78f360ecc48c60bc4ad5
> -- 
> 2.36.1
> 

-- 
மணிவண்ணன் சதாசிவம்
