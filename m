Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F585C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 23:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiEBX5I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 19:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiEBX4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:56:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E9233E94
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 16:53:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80D1861358
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 23:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC4FC385AC;
        Mon,  2 May 2022 23:52:58 +0000 (UTC)
Date:   Mon, 2 May 2022 19:52:51 -0400
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
Message-ID: <20220502195251.5d862365@rorschach.local.home>
In-Reply-To: <819939e3-285b-2a65-9c4c-85640d2a3a02@csgroup.eu>
References: <cover.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
        <1b9566f0e7185fb8fd8ef2535add7a081501ccc8.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
        <20220427095415.594e5120@gandalf.local.home>
        <1651129169.fpixr00hgx.naveen@linux.ibm.com>
        <20220428100602.7b215e52@gandalf.local.home>
        <819939e3-285b-2a65-9c4c-85640d2a3a02@csgroup.eu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2022 14:44:56 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> If we do that after the linking, won't it be a nightmare with the 
> trampolines installed by the linker when the destination is over the 24 
> bits limit ?

Not sure what you mean. The locations I'm talking about is the full
address saved in the __mcount_loc table (data section).

-- Steve
