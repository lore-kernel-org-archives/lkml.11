Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7023C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 17:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiEDRzq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 13:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359713AbiEDRkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 13:40:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF4947558
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:06:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62488B827B3
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 17:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65FFC385B4;
        Wed,  4 May 2022 17:06:48 +0000 (UTC)
Date:   Wed, 4 May 2022 13:06:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/2] recordmcount: Handle sections with no non-weak
 symbols
Message-ID: <20220504130642.7b9a301d@rorschach.local.home>
In-Reply-To: <72d17597-874c-f3a3-9398-0cc944350c5b@csgroup.eu>
References: <cover.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
        <1b9566f0e7185fb8fd8ef2535add7a081501ccc8.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
        <20220427095415.594e5120@gandalf.local.home>
        <1651129169.fpixr00hgx.naveen@linux.ibm.com>
        <20220428100602.7b215e52@gandalf.local.home>
        <819939e3-285b-2a65-9c4c-85640d2a3a02@csgroup.eu>
        <20220502195251.5d862365@rorschach.local.home>
        <6d5ff91a-560e-56ea-0047-175f712872c2@csgroup.eu>
        <20220503122533.6033647e@rorschach.local.home>
        <72d17597-874c-f3a3-9398-0cc944350c5b@csgroup.eu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 16:50:58 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> In vmlinux, relocations are resolved, trampolines are installed for 
> unreachable destinations and you don't anymore have a section with all 
> the relocations to mcount. It means 'recordmcount' or whatever tool we 
> use will have to read the code to find all direct calls to mcount, then 
> find all trampolines to mcount then find all calls to those trampolines.

OK, so what you are saying is that in the object file, we can see the
site that calls mcount, but when it is linked, it may not call mcount,
but instead it will call a trampoline that will call mcount, thus the
tool will need to find these calls to the trampolines that call mcount
as well as the locations that call mcount directly.

Did I get that right?

-- Steve
