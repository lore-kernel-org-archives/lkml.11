Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA2DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 00:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243269AbiFUAi7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 20:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbiFUAi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 20:38:57 -0400
Received: from relay3.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A61510FE8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 17:38:56 -0700 (PDT)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id B538D20FDD;
        Tue, 21 Jun 2022 00:38:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 254A08000A;
        Tue, 21 Jun 2022 00:38:52 +0000 (UTC)
Message-ID: <53d77ae6101a0f24cfb694174d4c7699424c57e8.camel@perches.com>
Subject: Re: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
From:   Joe Perches <joe@perches.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "enozhatsky@chromium.org" <enozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "willy@infradead.org" <willy@infradead.org>
Date:   Mon, 20 Jun 2022 17:38:51 -0700
In-Reply-To: <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
         <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
         <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Stat-Signature: 4q1qktg797qyt7kwq1opekn7fu3or1wu
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 254A08000A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18iuMOlb5rJsZQ4wQ5Qfk4CeiXDod72ZqY=
X-HE-Tag: 1655771932-377534
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-20 at 11:07 -0400, Kent Overstreet wrote:
> On Mon, Jun 20, 2022 at 04:19:31AM +0000, David Laight wrote:
> > I really think that is a bad idea.
> > printk() already uses a lot of stack, anything doing a recursive
> > call is just making that worse.
> > Especially since these calls can often be in error paths
> > which are not often tested and can already be on deep stacks.
> 
> We went over this before - this patch series drastically reduces stack usage of
> sprintf by eliminating a bunch of stack allocated buffers. Do try to keep up...

I generally agree with David.

I think Kent has not provided data that this actually _reduces_
stack usage.

Converting stack variables to call stack frames does not necessarily
reduce overall stack usage when the stack frame plus any locally
used stack in the called function is added together.

