Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0BDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 18:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiGLSAW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 14:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiGLSAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:00:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055EBB93C2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:00:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C98061A3E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 18:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7AAC3411C;
        Tue, 12 Jul 2022 18:00:03 +0000 (UTC)
Date:   Tue, 12 Jul 2022 14:00:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Arend van Spriel" <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        "Hante Meuleman" <hante.meuleman@broadcom.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Peter Chen <peter.chen@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bin Liu <b-liu@ti.com>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        Sven Eckelmann <sven@narfation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jim Cromie <jim.cromie@gmail.com>
Subject: Re: [PATCH 01/13] tracing/events: Add __vstring() and
 __assign_vstr() helper macros
Message-ID: <20220712140001.52bd8734@gandalf.local.home>
In-Reply-To: <76e12594cf81b57c98e536c68b2947f9ed0a4296.camel@mediatek.com>
References: <20220705224453.120955146@goodmis.org>
        <20220705224749.053570613@goodmis.org>
        <76e12594cf81b57c98e536c68b2947f9ed0a4296.camel@mediatek.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2022 09:35:53 +0800
Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:

> Seems difficult to get this patch without, such as, '--cc="
> linux-kernel@vger.kernel.org"'

Not sure what you mean by this. It was sent *To:*
linux-kernel@vger.kernel.org.

I don't need to add it to the Cc list. I never include it as all my kernel
patches go there by default.

-- Steve
