Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4200EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 17:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbiDHRsm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 13:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbiDHRsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:48:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC7FC6B53;
        Fri,  8 Apr 2022 10:46:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26F1CB82C89;
        Fri,  8 Apr 2022 17:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D4BC385A1;
        Fri,  8 Apr 2022 17:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649439985;
        bh=xuHSGWL0ExxjYNY7fixDPW1rR4sQ6XywWk6geBbHN54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JV5kzjp2U6Wh3Am4UY0dPfIfEvAGaM7AMGvxCCe2tvOllb+KuBkfAxMfNTW2vJbUA
         eNXqDL7/2aMZFXVD2eGOQlMNXrS8F1dgnP01O6vzyCMIbcJeWQEFD3+KjwY5qkiBxi
         UGpeEck8Ps/GXxTIXnHbOJlrBnREmXeB5IUDsCoKv5I9/L9XE6r3FnVKvCxf8YYvvS
         tPKu1bw6LCRkobFI+jO/j3B1t760h82grzzathl77YYNwNbP9iRpAo+KZ7I8r/3lsg
         Ncp/utHbHRi9vJ9kwzpKje8pnPDuZvr09ZD6OM9cJMHu/7zWB/XVcmv+XYpUEZ4zT4
         cxnN5Z4+NmUmg==
Date:   Fri, 8 Apr 2022 23:16:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] dmaengine: Use platform_get_irq*() variants to
 fetch IRQ's
Message-ID: <YlB07XRDWPHF7VaI@matsya>
References: <20220404155557.27316-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8tM3EiZkNSCG+CtrOnfGBc5WSaac__FBsRn72zrsjQ2ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8tM3EiZkNSCG+CtrOnfGBc5WSaac__FBsRn72zrsjQ2ew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-04-22, 03:52, Lad, Prabhakar wrote:
> Hi Vinod,
> 
> On Mon, Apr 4, 2022 at 4:56 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > Hi All,
> >
> > This patch series aims to drop using platform_get_resource() for IRQ types
> > in preparation for removal of static setup of IRQ resource from DT core
> > code.
> >
> Fyi.. the OF core changes have landed into -next [0].
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220406&id=a1a2b7125e1079cfcc13a116aa3af3df2f9e002b

Is this series dependent on this?

-- 
~Vinod
