Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C2EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 15:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiBXPUP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbiBXPSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:35 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47CF158D87
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=10PMYNQe5j29M0TdMxO4kPgHX3HLCDqT14Pm/MwrfbM=; b=dzRncKteWfA7bnwavR7kGjuy9s
        HX/JAtNBdJNvrpfgXeeu0HA1RnusV1MUlpwN4SGK9gWBb2q3/q/lcg5JZAke7wtdJ0Liy7T0eUwmW
        6Wzc1F7R+PeR19SBUhenRkJur0Vms8cxR2IFYpbuNp/QfA3BBnCGSd4/CMVWsUjbOZdFhbuVX/UQH
        5FwydFnYLATpyPjx90UQhRG7ezAg30UncKuvChlBpEFDrOLiMkvKoZ6dRAdj0lusMY6ttRw1JCnrG
        bySkIpPSu0mzU9GdnEvPZlKZYLBh51rhXZxAj1rhhbyKJDrBpKh5VDIPJxwmuhiKWg0xyV7uMd0ua
        LTuOGk6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs3-00CeM2-Vg; Thu, 24 Feb 2022 15:17:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B414302D4A;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 94B412B3547A3; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151323.780595386@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:52:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 30/39] Kbuild: Allow whole module objtool runs
References: <20220224145138.952963315@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like we have vmlinux.o objtool runs, add the ability to do whole
module objtool runs.

XXX it doesn't print OBJTOOL like:

 OBJTOOL  sound/usb/line6/snd-usb-variax.o
  LD [M]  sound/usb/line6/snd-usb-variax.ko

when linking modules.

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 scripts/Makefile.build    |   44 +-----------------------------------
 scripts/Makefile.lib      |   56 ++++++++++++++++++++++++++++++++++++++++++++++
 scripts/Makefile.modfinal |    1 
 3 files changed, 59 insertions(+), 42 deletions(-)

--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -223,41 +223,6 @@ cmd_record_mcount = $(if $(findstring $(
 	$(sub_cmd_record_mcount))
 endif # CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
 
-ifdef CONFIG_STACK_VALIDATION
-
-objtool := $(objtree)/tools/objtool/objtool
-
-objtool_args =								\
-	$(if $(CONFIG_UNWINDER_ORC),orc generate,check)			\
-	$(if $(part-of-module), --module)				\
-	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
-	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
-	$(if $(CONFIG_RETPOLINE), --retpoline)				\
-	$(if $(CONFIG_X86_SMAP), --uaccess)				\
-	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
-	$(if $(CONFIG_SLS), --sls)
-
-cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
-cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
-
-endif # CONFIG_STACK_VALIDATION
-
-ifdef CONFIG_LTO_CLANG
-
-# Skip objtool for LLVM bitcode
-$(obj)/%.o: objtool-enabled :=
-
-else
-
-# 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
-# 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
-# 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
-
-$(obj)/%.o: objtool-enabled = $(if $(filter-out y%, \
-	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y)
-
-endif
-
 ifdef CONFIG_TRIM_UNUSED_KSYMS
 cmd_gen_ksymdeps = \
 	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
@@ -292,21 +257,16 @@ ifdef CONFIG_LTO_CLANG
 # Module .o files may contain LLVM bitcode, compile them into native code
 # before ELF processing
 quiet_cmd_cc_lto_link_modules = LTO [M] $@
-cmd_cc_lto_link_modules =						\
+      cmd_cc_lto_link_modules =						\
 	$(LD) $(ld_flags) -r -o $@					\
 		$(shell [ -s $(@:.lto.o=.o.symversions) ] &&		\
 			echo -T $(@:.lto.o=.o.symversions))		\
 		--whole-archive $(filter-out FORCE,$^)			\
 		$(cmd_objtool)
-
-# objtool was skipped for LLVM bitcode, run it now that we have compiled
-# modules into native code
-$(obj)/%.lto.o: objtool-enabled = y
-$(obj)/%.lto.o: part-of-module := y
+endif
 
 $(obj)/%.lto.o: $(obj)/%.o FORCE
 	$(call if_changed,cc_lto_link_modules)
-endif
 
 cmd_mod = { \
 	echo $(if $($*-objs)$($*-y)$($*-m), $(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)), $(@:.mod=.o)); \
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -533,3 +533,59 @@ define filechk_offsets
 	 echo ""; \
 	 echo "#endif"
 endef
+
+# objtool
+# ---------------------------------------------------------------------------
+
+ifdef CONFIG_STACK_VALIDATION
+
+objtool := $(objtree)/tools/objtool/objtool
+
+objtool_args =								\
+	$(if $(CONFIG_UNWINDER_ORC),orc generate,check)			\
+	$(if $(part-of-module), --module)				\
+	$(if $(CONFIG_X86_KERNEL_IBT_SEAL), --lto --ibt --ibt-fix-direct --ibt-seal)	\
+	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
+	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
+	$(if $(CONFIG_RETPOLINE), --retpoline)				\
+	$(if $(CONFIG_X86_SMAP), --uaccess)				\
+	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
+	$(if $(CONFIG_SLS), --sls)
+
+cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
+cmd_objtool_mod = $(if $(objtool-enabled), $(objtool) $(objtool_args) $(@:.ko=.o) ; )
+cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
+
+endif # CONFIG_STACK_VALIDATION
+
+ifdef CONFIG_LTO_CLANG
+
+# Skip objtool for LLVM bitcode
+$(obj)/%.o: objtool-enabled :=
+
+# objtool was skipped for LLVM bitcode, run it now that we have compiled
+# modules into native code
+$(obj)/%.lto.o: objtool-enabled = y
+$(obj)/%.lto.o: part-of-module := y
+
+else ifdef CONFIG_X86_KERNEL_IBT_SEAL
+
+# Skip objtool on individual files
+$(obj)/%.o: objtool-enabled :=
+
+# instead run objtool on the module as a whole, right before
+# the final link pass with the linker script.
+%.ko: objtool-enabled = y
+%.ko: part-of-module := y
+
+else
+
+# 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
+# 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
+# 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
+
+$(obj)/%.o: objtool-enabled = $(if $(filter-out y%, \
+	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y)
+
+endif
+
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -32,6 +32,7 @@ ARCH_POSTLINK := $(wildcard $(srctree)/a
 
 quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o +=							\
+	$(cmd_objtool_mod)						\
 	$(LD) -r $(KBUILD_LDFLAGS)					\
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
 		-T scripts/module.lds -o $@ $(filter %.o, $^);		\


