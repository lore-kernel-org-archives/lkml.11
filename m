Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECA9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 11:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349652AbiDZLt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 07:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiDZLtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:49:25 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21C2A2ED66;
        Tue, 26 Apr 2022 04:46:17 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 23QBccrP019162;
        Tue, 26 Apr 2022 06:38:38 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 23QBcZpU019161;
        Tue, 26 Apr 2022 06:38:35 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 26 Apr 2022 06:38:35 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Suresh Warrier <warrier@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: powerpc: remove extraneous asterisk from rm_host_ipi_action comment
Message-ID: <20220426113835.GM25951@gate.crashing.org>
References: <20220426074750.71251-1-bagasdotme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426074750.71251-1-bagasdotme@gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 02:47:51PM +0700, Bagas Sanjaya wrote:
> kernel test robot reported kernel-doc warning for rm_host_ipi_action():
> 
> arch/powerpc/kvm/book3s_hv_rm_xics.c:887: warning: This comment
> starts with '/**', but isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst
> 
> Since the function is static, remove the extraneous (second) asterisk at
> the head of function comment.
> 
> Link: https://lore.kernel.org/linux-doc/202204252334.Cd2IsiII-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Suresh Warrier <warrier@linux.vnet.ibm.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>

Please do not Cc: me on random patches, I get enough mail already :-)


Segher
