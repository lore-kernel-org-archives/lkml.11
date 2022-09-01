Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB367ECAAD3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 15:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbiIAP2r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbiIAP2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:28:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAD074DF1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B383861E9E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D30BC433D6;
        Thu,  1 Sep 2022 15:28:22 +0000 (UTC)
Date:   Thu, 1 Sep 2022 11:28:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 2/3] regmap: trace: Remove explicit castings
Message-ID: <20220901112853.641cc67a@gandalf.local.home>
In-Reply-To: <YxDGqdzv3uvEgALv@sirena.org.uk>
References: <20220901132336.33234-1-andriy.shevchenko@linux.intel.com>
        <20220901132336.33234-2-andriy.shevchenko@linux.intel.com>
        <YxC0SYShl14TSw2o@sirena.org.uk>
        <CAHp75VcrBS=+bxXz62HB6joB3+6meVK9YJtJOYSS3PNrY13AVg@mail.gmail.com>
        <20220901104601.01773fb8@gandalf.local.home>
        <YxDGqdzv3uvEgALv@sirena.org.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2022 15:50:17 +0100
Mark Brown <broonie@kernel.org> wrote:

> > fb2736bbaee0e ("regmap: Add basic tracepoints")  
> 
> Right, they were added in the original commit because as far as I could
> tell at that time they were needed for things to build (or possibly
> build cleanly, it's been a while).

I'm guessing what happened as things were probably a bit confusing back
then, it was something else that didn't build, and you probably tried all
sorts of things and when it worked, you just left it as is ;-)

-- Steve
