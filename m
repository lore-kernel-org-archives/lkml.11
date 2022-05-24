Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDCCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 18:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbiEXSFf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 14:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiEXSFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:05:30 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5642E1FCEE
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:05:28 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 24OHxu8g026332;
        Tue, 24 May 2022 12:59:56 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 24OHxtwj026331;
        Tue, 24 May 2022 12:59:55 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 24 May 2022 12:59:55 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
Message-ID: <20220524175955.GI25951@gate.crashing.org>
References: <20220524093939.30927-1-pali@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220524093939.30927-1-pali@kernel.org>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, May 24, 2022 at 11:39:39AM +0200, Pali Rohár wrote:
> gcc e500 compiler does not support -mcpu=powerpc option. When it is
> specified then gcc throws compile error:
> 
>   gcc: error: unrecognized argument in option ‘-mcpu=powerpc’
>   gcc: note: valid arguments to ‘-mcpu=’ are: 8540 8548 native

What?  Are you using some modified version of GCC, perhaps?  No version
of GCC that isn't hamstrung can have this output.


Segher
