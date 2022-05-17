Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE93C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 13:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347200AbiEQNJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 09:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbiEQNJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:09:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F5435267;
        Tue, 17 May 2022 06:09:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id A2E9B1F444FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652792971;
        bh=xNlpc1F54muTtr/z6RaIWW7IyIDJ/ccOrpEag1kxRY0=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=KDnZ/Esd0KFmaNmaa2agEpHbzNnQooi2fseRoNXogH+pvDy/sxy4EmcyjYFBrZ/5c
         C1Bx0BJBxy2S+6pCPAScHlJKK2wuVGFaT+dX+jb5Qadmg3AR4zozG2aLIxSy1PCDpW
         6j1/ocxXbpPbpkSVlCc8/8K57nSVbCyKrV5nl9Fc4iy3pHoSMWiwWFqB7x9nO45bLl
         B8ThvCr0NOV5h/U0Tflcsokrydi3VK4V+iJ6f8fUekNXdgWjB6OlelYPzLQpasuWyA
         KmpEiitplMjeySVR61i+RsdclsBaodOEu2Uc1Jwh/J4JLaOpQcrLItsV5rv4Pn3Weu
         d3G5iA4fmtm5A==
Message-ID: <5d148732-c14d-4e96-f8fc-31acc8932534@collabora.com>
Date:   Tue, 17 May 2022 18:09:25 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     usama.anjum@collabora.com, Tzung-Bi Shih <tzungbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the chrome-platform tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20220516213832.19127535@canb.auug.org.au>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220516213832.19127535@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 4:38 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the chrome-platform tree, today's linux-next build
> (htmldocs) produced this warning:
> 
> Documentation/ABI/testing/sysfs-driver-chromeos-acpi:2: WARNING: Unexpected indentation.
> Documentation/ABI/testing/sysfs-driver-chromeos-acpi:11: WARNING: Unexpected indentation.
> Documentation/ABI/testing/sysfs-driver-chromeos-acpi:22: WARNING: Unexpected indentation.
> Documentation/ABI/testing/sysfs-driver-chromeos-acpi:56: WARNING: Unexpected indentation.
> 
> Introduced by commit
> 
>   0a4cad9c11ad ("platform/chrome: Add ChromeOS ACPI device driver")
> 
I've found these warnings in local build. But I'm unable to fix them.
Apparently, there doesn't seem any unexpected indentation. This kind of
same warnings have also appeared on some more files before this commit
without any reason.

-- 
Muhammad Usama Anjum
