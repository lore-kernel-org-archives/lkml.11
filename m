Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13C7C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jul 2022 13:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiGUNfF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGUNfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:35:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AE25A44B;
        Thu, 21 Jul 2022 06:35:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D424B82505;
        Thu, 21 Jul 2022 13:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2181BC341C6;
        Thu, 21 Jul 2022 13:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658410499;
        bh=LotosDg6OqPi/QeVcyfUiP3kmxKG1o5zdHj+YsZWQ9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UX8CdA026mJAPAHm2TucVcx5xnfwh8f5p4Ojy59QPYi57r89CSa7tf3aXaUcmm821
         YFm4AtJMMcEKxzwA8NeHTH2CA2+0uPk6idLhf6vRa03QDBrGAAuAMAAc3Bc+MhHA6Z
         VS9FILAwIlgpDHC2M4RCWBMtTzR+xrQOMfz//JI/n8WerNdQoMOyWHRIHZdqVVEx+M
         KjPNw+38GHw7CqYiTWIK0qDtzT1Snh3V/UeuC4QMrmHdXEfa4zlHRiKsiQgr4N2dC7
         feSEpWw6l+ap/XrMX6RC7UEiQmNUW0kZvYIJ6kymCQGc8ztoNs9BXPlirZgy+rNwxQ
         xqUxlIIG1NFsw==
Date:   Thu, 21 Jul 2022 19:04:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     XueBing Chen <chenxuebing@jari.cn>
Cc:     hyun.kwon@xilinx.com, laurent.pinchart@ideasonboard.com,
        michal.simek@xilinx.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: xilinx: use strscpy to replace strlcpy
Message-ID: <YtlV/9YmSrAZcnSI@matsya>
References: <39aa840f.e31.181ed9461c2.Coremail.chenxuebing@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39aa840f.e31.181ed9461c2.Coremail.chenxuebing@jari.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-07-22, 22:05, XueBing Chen wrote:
> 
> The strlcpy should not be used because it doesn't limit the source
> length. Preferred is strscpy.

Applied, thanks

-- 
~Vinod
