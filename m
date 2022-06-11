Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9CDC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jun 2022 12:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiFKM4W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jun 2022 08:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiFKM4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 08:56:21 -0400
X-Greylist: delayed 538 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Jun 2022 05:56:19 PDT
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C0C4C7AA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 05:56:19 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 7BA4AC01E; Sat, 11 Jun 2022 14:47:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1654951639; bh=yg3XVHIPgoJ44t4DpuHgig9s2UdIwMKjMb0MG6tDqPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W82djJwO4MgIjJVV87dMcSorVAL4pLf2Bl0W3eVp1wBwRb70AN5C/lqILfPWseRIl
         G+CPVE2nOiQ20EPz33CLJDPqir7HD1s/Le86r32LuiBxQ+ZZKsQPKCOFoh+1R53BCC
         F2WaLEKoDeq8TK2UmweZokystZ6WIa5K8TrN33z6sEaJp2gp1CN9q4v/3Qhl85qBcN
         Q5VRAtu30wZ8mLl7s3+SbY8Eajxa1VTfBQ2sq4MKWKhUXuKaUVe+vj+QlJ6wNsZfYz
         vMXeZmeeC9H+gAjQVwLBv4RGDlIimk7OMkw+t7rCMrHHKY4J0FgVEb57L5g4kGOMTr
         KJuHri/7bq9zg==
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id B1E7DC009;
        Sat, 11 Jun 2022 14:47:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1654951638; bh=yg3XVHIPgoJ44t4DpuHgig9s2UdIwMKjMb0MG6tDqPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aadvztkrK50Ba661yI+TldRp8GCekyJds9Ry/po9TwJLPX9TNXnrUf+s/SoAFeqJl
         52jI1wI9tTzUsi8VpM79NlDexEDPXnjygJF0Gv996C6SRJYigP9cKJXPpTm0INgipe
         4nidcFe2rn6/4cH1SkvOzHWEwlQ+Grmvu4Opi4ybjUr6YNbaR6JavYb+5pw7ngafsu
         fRxChMKmkv0s+W1bEzCHz0YtYW64eiLuMLE+uqA3Biiy7QyqBzUAJ91TJ9Fhy766Cn
         u8djYC3vO/5F97SmSjkJae+QAHKK/nU+/OvVlTU76mG70YmDOQ6pZkVvAd0NHqTxIk
         L2ErGBk3fA3ig==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id d56235ef;
        Sat, 11 Jun 2022 12:47:14 +0000 (UTC)
Date:   Sat, 11 Jun 2022 21:46:59 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jianyong Wu <jianyong.wu@arm.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] 9p: Fix refcounting during full path walks for
 fid lookups
Message-ID: <YqSOw+BwBbJ8WH73@codewreck.org>
References: <20220527000003.355812-1-tyhicks@linux.microsoft.com>
 <1849605.JvGbLJQp6r@silver>
 <20220607034110.GA7401@sequoia>
 <7291261.iO0hoOTYzs@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7291261.iO0hoOTYzs@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Thu, Jun 09, 2022 at 02:44:04PM +0200:
> Dominique is the only active 9p maintainer for a while and barely has time for 
> 9p anymore (hint: implied call for volunteers hidden in this sentence).
> 
> Dominique, do you have a time slice for this issue? I agree that it makes 
> sense to bring this issue forward.

Sorry for lack of replies, I've updated my mail configuration a few
weeks ago and somehow screwed up 9p mails -- I've received everything,
just never got notified...

As Christian put it so well I don't have much time, but I can take a
couple of hours tomorrow.
Will review and/or take patches then hopefully :)

-- 
Dominique
