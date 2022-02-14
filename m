Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8B8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 18:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349714AbiBNS14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 13:27:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiBNS1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:27:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6D7496BB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=93oBqhRfGyp81erZawUocVFg/qlY90+qZLcs405SMv0=; b=vWu3W4we2fdhM5wZ76QSxQy5W2
        lKa4zewyd1VhEAHkacc//5dUs2MWC/eFl5uS+/Yt/ba4EL1D4WD0oRaR/OlEJ/8dISj6Q6Ri35dJJ
        SFs+dhwZ3ldCkowTYS7WVBWxcj7vz4orDa/gXd7rw7H9rzNnSIDvJE0+E175Nhk7ZQxCb+TdmKvfm
        xqdQUFyPFx5hxn/fZZJpKgdH/0qAwn5KW9iB7hMG5sp5pIiQH5Yv20zsDNkAPQzUnPXdJeGOfiDkw
        hsAPjmI4M4uCR/zkLGm2NL2lgfcM0zG8W+gXLWnnxjDdauXtfshakyPg/avDGdvvwqnfz3VRowfdI
        Cs3A1gZQ==;
Received: from [2602:306:c5a2:a380:b27b:25ff:fe2c:51a8]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJg4K-00D9vw-RT; Mon, 14 Feb 2022 18:27:25 +0000
Message-ID: <aa6c446a-02f8-02d3-bd1a-19b5d729eb91@infradead.org>
Date:   Mon, 14 Feb 2022 10:27:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] powerpc/boot: Add `otheros-too-big.bld` to .gitignore
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220214065543.198992-1-pmenzel@molgen.mpg.de>
From:   Geoff Levand <geoff@infradead.org>
In-Reply-To: <20220214065543.198992-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2/13/22 22:55, Paul Menzel wrote:
> Currently, `git status` lists the file as untracked by git, so tell git
> to ignore it.

Thanks for your contribution.

Acked-by: Geoff Levand <geoff@infradead.org>

