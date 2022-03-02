Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0A7C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 14:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242878AbiCBOXb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 09:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbiCBOXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:23:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF373CA47;
        Wed,  2 Mar 2022 06:22:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBB06B81F16;
        Wed,  2 Mar 2022 14:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A177AC004E1;
        Wed,  2 Mar 2022 14:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646230958;
        bh=gtQk75T3qKDxWoDQiGWygKCOzdyAYhEBNXZLCyqiv0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i22xKKX0SQD3c2kRTiVGhQmy0lDN0stgowJAclW1NmZbMgrB2gX93GGnFGrD33HtO
         zAEXtNZBtM5wIau9y191ZpsXONrZTMg+aIeZZ+7vf6gYmqGCVyZL0rkC0JTgntPscu
         bah6ZdaB0gk+YEraw4R4Lc0cZxCc2KGz4cSeVxeIGwpICfNCsk9omrVMdIVHn7impW
         5AdCPag9H2wQN+O6s8I+bBqaZ4jPzSfz2jFD/xUGbDSUZ4ajriXJU9hrMYAIi/29sO
         07K9ejfdoVFMIV7jCet3zH9iVRaof0i1hM5BS1CtiOBdUdMXihT5bZsWNDF/EqXqRj
         LEynYA0zgVaIw==
Date:   Wed, 2 Mar 2022 19:52:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/8] dt-bindings: soc: grf: fix rk3568 usb definitions
Message-ID: <Yh99qVeALFN3X9te@matsya>
References: <20220228135700.1089526-1-pgwipeout@gmail.com>
 <20220228135700.1089526-2-pgwipeout@gmail.com>
 <CAMdYzYqs=iRY6uNzVSkHrrhPYFixXdbZjtwSpPOjf-6f8TXutw@mail.gmail.com>
 <Yh8n7XiJbaT4pZGD@matsya>
 <CAMdYzYrkDbr5mHYmAbqBoJJEKH8A5xXfRNuTiTn8q40vRJeCgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYrkDbr5mHYmAbqBoJJEKH8A5xXfRNuTiTn8q40vRJeCgA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-03-22, 07:18, Peter Geis wrote:
> On Wed, Mar 2, 2022 at 3:16 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 01-03-22, 09:52, Peter Geis wrote:
> > > Good Morning,
> > >
> > > Would it be possible to pull this patch individually, to fix the
> > > current error reported by Rob?
> >
> > This does not apply for me on phy-next. What was this based on..?
> 
> This is based on linux-next, which the applicable patch was accepted on 24 Feb.
> The original patch was correct, but it seems a merge error happened
> and these two lines were moved into an incorrect location.
> This patch corrects that, but I see on the original patch chain you
> are discussing reverting and reapplying to fix it.

Ok let me revert than so that it is easy for everyone to fix up

Thanks

-- 
~Vinod
