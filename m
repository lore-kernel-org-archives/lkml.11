Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AACDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 14:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355358AbiELOeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 10:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355338AbiELOeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:34:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8DE25D12C
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B33DAB82849
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D55CC385B8;
        Thu, 12 May 2022 14:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652366045;
        bh=+VduWayOmtcH6O/mvjr3we6gcm+gXGGxHqxhMO/VH/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nds1eaKNXxDNRARvWUWqqMBrZltsBd+heJcSy5FlWGM7aYNE1od3+nehiF7HU2yyk
         Bhw1qcTtu02A39Zr+1lyMkRDEfTR2PuHbkxCvAx6mnKxoYEwem2Ok7g/ybt/kSPFwr
         J0QoOnp5qPSIqZ5c1Cx6kQJawwPmcTZkhCLTB3GRr5Cz6P1wvbnwCnyeeez+OYKqr+
         DbV6cEVaBF28u+Bd5j/mQIkHt6FvBvIsKjMjnLy+Oh0rE1xIoJ/nafPCbqmfwD9E+O
         Ywr2f3JEpCJTxxRfYFtyqGAntjRJy0P75In8jlM2qVTfXKduBFiCRBV3U9OygBKMWE
         OqoBcSuocEiRQ==
Date:   Thu, 12 May 2022 07:34:03 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] objtool: Remove some files when make clean
Message-ID: <20220512143403.ryc3whypcmwnnyri@treble>
References: <1652258270-6278-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1652258270-6278-1-git-send-email-yangtiezhu@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 04:37:48PM +0800, Tiezhu Yang wrote:
> Tiezhu Yang (2):
>   objtool: Remove inat-tables.c when make clean
>   objtool: Remove libsubcmd.a when make clean
> 
>  tools/objtool/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!

-- 
Josh
