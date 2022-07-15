Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD90CCA47C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 14:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiGOOgv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 10:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiGOOgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:36:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C622E4E856;
        Fri, 15 Jul 2022 07:36:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BB636177D;
        Fri, 15 Jul 2022 14:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3862C34115;
        Fri, 15 Jul 2022 14:36:46 +0000 (UTC)
Date:   Fri, 15 Jul 2022 10:36:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [for-next][PATCH 13/23] USB: mtu3: tracing: Use the new
 __vstring() helper
Message-ID: <20220715103645.484f08e9@gandalf.local.home>
In-Reply-To: <962e59c25e981676014157cd111db9e16e237339.camel@mediatek.com>
References: <20220714164256.403842845@goodmis.org>
        <20220714164330.311734558@goodmis.org>
        <962e59c25e981676014157cd111db9e16e237339.camel@mediatek.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 18:01:44 +0800
Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:

> the second and third lines with this patch:
>  irq/254-1120100-137     [000] d..1.   266.629399: mtu3_log:
> 11201000.usb: link speed super-speed
> 
>  irq/254-1120100-137     [000] d..1.   266.629662: mtu3_log:
> 11201000.usb: ep0_state SETUPr-speed
> 
> "r-speed" seems the remain of last log;

Thanks for testing! I'll investigate. (Another reason I didn't push to
linux-next yet).

-- Steve
