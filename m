Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17EFC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 10:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376295AbiFPKJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 06:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358706AbiFPKJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:09:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49A25C86E;
        Thu, 16 Jun 2022 03:08:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 504B86158A;
        Thu, 16 Jun 2022 10:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22189C3411C;
        Thu, 16 Jun 2022 10:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655374138;
        bh=WjhFuQTsGkEU13jyp5Zn8zUadcjOo0hy77oeeLB3pVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OWHHpY0wHTx4xPaCBbGLPIgqVPi5VJdPF8I/heqgzifPvhe5gwjGy3GTpWDQZfW2C
         AVsoCPlKIIY9/7NhM1yW3tjJWRkbSQhv7TERBwmRGNEF/VdbWMna8xaE9R2yEqHrDN
         SqgOzPCA1HNw1z2ipA6GXN8dm0QhIireNoYmiYkI=
Date:   Thu, 16 Jun 2022 12:08:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YqsBN2qtjCkNtVM0@kroah.com>
References: <20220616092737.1713667-1-sebastianene@google.com>
 <20220616092737.1713667-3-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616092737.1713667-3-sebastianene@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 09:27:39AM +0000, Sebastian Ene wrote:
> This driver creates per-cpu hrtimers which are required to do the
> periodic 'pet' operation. On a conventional watchdog-core driver, the
> userspace is responsible for delivering the 'pet' events by writing to
> the particular /dev/watchdogN node. In this case we require a strong
> thread affinity to be able to account for lost time on a per vCPU.
> 
> This part of the driver is the 'frontend' which is reponsible for
> delivering the periodic 'pet' events, configuring the virtual peripheral
> and listening for cpu hotplug events. The other part of the driver
> handles the peripheral emulation and this part accounts for lost time by
> looking at the /proc/{}/task/{}/stat entries and is located here:
> https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
> 
> Reported-by: kernel test robot <lkp@intel.com>

The robot reported stalls on vcpus?

I think you need to fix this up...

greg k-h
