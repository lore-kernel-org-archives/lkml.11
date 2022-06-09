Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBC8C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 06:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbiFIGvc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 02:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiFIGva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 02:51:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFA2517C8;
        Wed,  8 Jun 2022 23:51:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCAD561DD6;
        Thu,  9 Jun 2022 06:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCF7C34114;
        Thu,  9 Jun 2022 06:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654757488;
        bh=nz0AL1nUq9zqtSt05rPkuSm++nyB3Le+WXo70pg/YmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t6X0xtqkC3/2mtCFcIoNaNrGzcyM5pjLQr88Ion/ahl0rNLG69JF6NwuwJ9NaweUL
         78CYpTHSRad69b5+zfRQQCtl2qrz3SchzvHnhOWddK3cBm3IWPqSWmaG//L9HbyZlk
         Aelc5FeF47CAKKMqBtRp1zNZ/oF4InDJne4Ko3DgOJJcg4fYWwPsZRSnErqY38bfpa
         WUgUe5ZeqSxApePm/QpiWt6ISHw+XDtAtoJGLx/1OgnWAf0lqVTgOmVQJwbTDDABNN
         E09OyF+sVplikad7+QcVv3xue5gxd4q4s2vJk8KkltHPWqNIt9QJqzEWu2kXFfOlkW
         qoCa67gH4sAfA==
Date:   Thu, 9 Jun 2022 12:21:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH v4 0/3] Apple ADMAC driver
Message-ID: <YqGYa/yoj+CG+3Uq@matsya>
References: <20220531213615.7822-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220531213615.7822-1-povik+lin@cutebit.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-05-22, 23:36, Martin Povišer wrote:
> Hi,
> 
> I am doing another push of this neglected series which adds support for
> Audio DMA Controller on recent Apple SoCs.

Applied, thanks

-- 
~Vinod
