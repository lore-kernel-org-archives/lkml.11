Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66195C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 14:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbiFVOqQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiFVOqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:46:14 -0400
Received: from relay4.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008C53CA4E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:46:12 -0700 (PDT)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 880A0211D8;
        Wed, 22 Jun 2022 14:46:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 1E1AA38;
        Wed, 22 Jun 2022 14:46:06 +0000 (UTC)
Message-ID: <37d560bc5267408eb9cc806339025418094cf5bb.camel@perches.com>
Subject: Re: [PATCH] MIPS: Fix 2 typos
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Zhang Jiaming <jiaming@nfschina.com>, tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com
Date:   Wed, 22 Jun 2022 07:46:01 -0700
In-Reply-To: <d2112863-bd28-d6db-c353-1b7b94b45fcb@infradead.org>
References: <20220622090713.24370-1-jiaming@nfschina.com>
         <d2112863-bd28-d6db-c353-1b7b94b45fcb@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Stat-Signature: abnynm7f41xexum4qqrwzek1ynrc653a
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 1E1AA38
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19lgcxluOxcGqjU5XTKXoTq92I4KprCEbA=
X-HE-Tag: 1655909166-228282
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-22 at 07:28 -0700, Randy Dunlap wrote:
> On 6/22/22 02:07, Zhang Jiaming wrote:
> > Change 'modifed' to 'modified'.
> > Change 'relys' to 'relays'.
[]
> > diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
[]
> > @@ -282,9 +282,9 @@ union cvmx_helper_link_info __cvmx_helper_board_link_get(int ipd_port)
> >   * support and should return the number of actual ports on the
> >   * board.
> >   *
> > - * This function must be modifed for every new Octeon board.
> > + * This function must be modified for every new Octeon board.
> >   * Internally it uses switch statements based on the cvmx_sysinfo
> > - * data to determine board types and revisions. It relys on the
> 
>                                                       relies
> 
> But it would be better to restrict this barrage (or swarm) of patches
> to Kconfig help text problems and/or strings that are printed to users.

I believe fixing typos isn't a particular problem and is
overall rather a good thing.

Though backporting these patches would be silly.

