Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E420C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Apr 2022 09:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356433AbiD2JWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Apr 2022 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356429AbiD2JWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:22:37 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FCB1C44F3;
        Fri, 29 Apr 2022 02:19:20 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D4E9192009C; Fri, 29 Apr 2022 11:19:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id CF6F492009B;
        Fri, 29 Apr 2022 10:19:18 +0100 (BST)
Date:   Fri, 29 Apr 2022 10:19:18 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Stephen Zhang <starzhangzsd@gmail.com>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        liam.howlett@oracle.com, ebiederm@xmission.com, dbueso@suse.de,
        alobakin@pm.me, f.fainelli@gmail.com, paul@crapouillou.net,
        linux@roeck-us.net, anemo@mba.ocn.ne.jp, zhangshida@kylinos.cn,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: undefine and redefine cpu_has_fpu when it is
 overrided
In-Reply-To: <20220429032621.674865-1-starzhangzsd@gmail.com>
Message-ID: <alpine.DEB.2.21.2204291016530.9383@angie.orcam.me.uk>
References: <20220429032621.674865-1-starzhangzsd@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022, Stephen Zhang wrote:

> Undefine and redefine cpu_has_fpu to 0 when it is overridden with
> the "nofpu" option.

 Umm, `nofpu' is a kernel parameter, not the CONFIG_MIPS_FP_SUPPORT config 
option; cf. Documentation/admin-guide/kernel-parameters.txt.

  Maciej
