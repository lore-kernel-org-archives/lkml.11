Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3470C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 10:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348028AbiCKKgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 05:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348027AbiCKKg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:36:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13DC115960;
        Fri, 11 Mar 2022 02:35:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82FD8B82B26;
        Fri, 11 Mar 2022 10:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD37C340E9;
        Fri, 11 Mar 2022 10:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646994913;
        bh=wm21xJ5baeJkPPj20x7VMn4tjjFzIKcijQ8aYc6wCCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=urCsqq81srgWnxBxhy9F1NKaTMHHFWdjAW6oWLs5Ypm7sIheRwHLLnNf3pEqeBIKw
         ZAB67zR0zufKxLzt2YHcI0rceWq90vOOQBaGh3/y507kjPwe7C9Tlww8Ep/OSAwFtX
         NFjdUrscnENIbr+YRL1W5F1jO1zJOdbTNiKdsX+y9eFw259ygEcGfH0sHfR95vDIbn
         mgRJfbaDalFPs2MshVMuwIA9h5DQ4W2oVVCQJfbszH8ROGeV2dDzhk9RPpKmi89BkD
         iaOAxtfOpxbvrKcyKrSF08CiOjAWUnLBOXvLc4V2yf6ci+9knfXeusFPh6IcLT+Gr1
         3EjsQkbgBDGqw==
Date:   Fri, 11 Mar 2022 16:05:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     trix@redhat.com
Cc:     Eugeniy.Paltsev@synopsys.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: cleanup comments
Message-ID: <Yisl3cliIotPpFkl@matsya>
References: <20220309020056.1026106-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309020056.1026106-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-03-22, 18:00, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> For spdx, /* */ for *.h, remove extra space
> 
> Replacements
> configurarion to configuration
> inerrupts to interrupts
> chanels to channels

Applied, thanks

-- 
~Vinod
