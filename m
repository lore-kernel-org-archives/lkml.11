Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F2DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 11:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiCaLfw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 07:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiCaLfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:35:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FF9148678
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:34:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1956B81BE2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63BFC340EE;
        Thu, 31 Mar 2022 11:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648726438;
        bh=cjZmh4LdpDHRvlpgeNidC1QaRwP08X6tDdjVpm3xYGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaQ5coN5SmKou+2F7UPD6+lpEu+jU0MMHN4fhg6QITovSIruPU1636r/lMrRPBxMW
         7Egpw8lfRyvT+zTl7oKd7XmWYGoUeRTn04xMJQv8fpFRfaq1DVYJfrcdUqymzn1nxg
         SLwqGj8zsoRTkghVTd1iluyx8ZnM/meuW3BHAlzk=
Date:   Thu, 31 Mar 2022 13:33:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: Fix Duplication of Side Effects
Message-ID: <YkWRort8Fsnndxf2@kroah.com>
References: <20220331101849.71046-1-eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331101849.71046-1-eng.alaamohamedsoliman.am@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 12:18:49PM +0200, Alaa Mohamed wrote:
> Fix Duplication of Side Effects for GDM_TTY_READY(gdm) macro
> reported by checkpatch
> "CHECK: Macro argument reuse 'gdm' - possible side-effects?"

There are no such side-effects here, sorry.  Please always evaluate the
code to see what it does, checkpatch sometimes gets it wrong.

thanks,

greg k-h
